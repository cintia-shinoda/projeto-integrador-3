import 'package:flutter/material.dart';
import '../models/kanji.dart';

class KanjiTracingGame extends StatefulWidget {
  final Kanji kanji;
  final bool modoAltoContraste;

  const KanjiTracingGame({
    super.key,
    required this.kanji,
    required this.modoAltoContraste,
  });

  @override
  State<KanjiTracingGame> createState() => _KanjiTracingGameState();
}

class _KanjiTracingGameState extends State<KanjiTracingGame> {
  List<Offset> pontos = [];
  int tracoAtual = 0;
  String mensagem = '';

  static const double maxX = 300;
  static const double maxY = 300;

  bool _verificarTraco(Offset inicio, Offset fim, Size size) {
    if (tracoAtual >= widget.kanji.tracos.length) return false;

    final esperado = widget.kanji.tracos[tracoAtual];
    if (esperado.pontoInicio == null || esperado.pontoFim == null) return false;

    // Aplicar mesma escala dos traços
    final double scaleX = size.width / maxX;
    final double scaleY = size.height / maxY;

    final Offset inicioEsperado = Offset(
      esperado.pontoInicio!.dx * scaleX,
      esperado.pontoInicio!.dy * scaleY,
    );
    final Offset fimEsperado = Offset(
      esperado.pontoFim!.dx * scaleX,
      esperado.pontoFim!.dy * scaleY,
    );

    final direcaoEsperada = (fimEsperado - inicioEsperado).direction;
    final direcaoFeita = (fim - inicio).direction;
    final deltaDirecao = (direcaoEsperada - direcaoFeita).abs();

    final segmento = fimEsperado - inicioEsperado;
    double somaDistancias = 0;
    for (final p in pontos) {
      somaDistancias += _distanciaAoSegmento(p, inicioEsperado, fimEsperado);
    }
    final mediaDistancia = somaDistancias / pontos.length;

    const toleranciaDirecao = 1.2;
    const toleranciaDistancia = 50.0;

    final passou = deltaDirecao < toleranciaDirecao && mediaDistancia < toleranciaDistancia;

    debugPrint('🧪 Traço verificado:');
    debugPrint('- Ângulo esperado: $direcaoEsperada');
    debugPrint('- Ângulo feito: $direcaoFeita');
    debugPrint('- Delta ângulo: $deltaDirecao');
    debugPrint('- Distância média: $mediaDistancia');
    debugPrint('- Resultado: ${passou ? '✅ CORRETO' : '❌ ERRADO'}');

    return passou;
  }

  double _distanciaAoSegmento(Offset p, Offset a, Offset b) {
    final ab = b - a;
    final ap = p - a;
    final t = (ap.dx * ab.dx + ap.dy * ab.dy) / (ab.distanceSquared == 0 ? 1 : ab.distanceSquared);
    final pontoMaisProximo = a + ab * t.clamp(0.0, 1.0);
    return (p - pontoMaisProximo).distance;
  }

  void _limpar() {
    setState(() {
      pontos.clear();
      mensagem = '';
    });
  }

  Widget _buildGestureCanvas() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onPanStart: (details) {
            final box = context.findRenderObject() as RenderBox;
            Offset local = box.globalToLocal(details.globalPosition);
            pontos = [local];
          },
          onPanUpdate: (details) {
            final box = context.findRenderObject() as RenderBox;
            Offset local = box.globalToLocal(details.globalPosition);
            setState(() => pontos.add(local));
          },
          onPanEnd: (_) {
            if (pontos.length < 2) return;
            Offset inicio = pontos.first;
            Offset fim = pontos.last;

            final box = context.findRenderObject() as RenderBox;
            final size = box.size;

            if (_verificarTraco(inicio, fim, size)) {
              setState(() {
                tracoAtual++;
                mensagem = '✅ Traço $tracoAtual correto!';
                pontos.clear();
              });
            } else {
              setState(() {
                mensagem = '❌ Tente novamente';
                pontos.clear();
              });
            }
          },
          child: CustomPaint(
            painter: _KanjiGamePainter(
              pontos,
              widget.kanji.tracos,
              tracoAtual,
              widget.modoAltoContraste,
            ),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: Container(
            color: Colors.white,
            child: _buildGestureCanvas(),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          mensagem,
          style: TextStyle(
            fontSize: 18,
            color: mensagem.contains('✅') ? Colors.green : Colors.red,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 20,
          alignment: WrapAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _limpar,
              icon: const Icon(Icons.refresh),
              label: const Text('Limpar'),
            ),
          ],
        ),
      ],
    );
  }
}

class _KanjiGamePainter extends CustomPainter {
  final List<Offset> pontos;
  final List<Traco> tracos;
  final int tracoAtual;
  final bool modoAltoContraste;

  _KanjiGamePainter(this.pontos, this.tracos, this.tracoAtual, this.modoAltoContraste);

  static const double maxX = 300;
  static const double maxY = 300;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / maxX;
    final double scaleY = size.height / maxY;

    for (int i = 0; i < tracos.length; i++) {
      final t = tracos[i];
      if (t.pontoInicio == null || t.pontoFim == null) continue;

      final Offset inicio = Offset(
        t.pontoInicio!.dx * scaleX,
        t.pontoInicio!.dy * scaleY,
      );
      final Offset fim = Offset(
        t.pontoFim!.dx * scaleX,
        t.pontoFim!.dy * scaleY,
      );

      final paintGuia = Paint()
        ..color = i < tracoAtual
            ? Colors.green
            : (modoAltoContraste ? Colors.yellow : Colors.grey.shade300)
        ..strokeWidth = 8
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(inicio, fim, paintGuia);
    }

    final paintDesenho = Paint()
      ..color = Colors.black
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < pontos.length - 1; i++) {
      canvas.drawLine(pontos[i], pontos[i + 1], paintDesenho);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}