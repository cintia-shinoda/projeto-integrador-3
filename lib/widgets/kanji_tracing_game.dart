import 'dart:math';
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
  int pontuacao = 0;
  String mensagem = '';

  bool _verificarTraco(Offset inicio, Offset fim) {
    if (tracoAtual >= widget.kanji.tracos.length) return false;
    final esperado = widget.kanji.tracos[tracoAtual];
    if (esperado.pontoInicio == null || esperado.pontoFim == null) return false;

    final direcaoEsperada = (esperado.pontoFim! - esperado.pontoInicio!).direction;
    final direcaoFeita = (fim - inicio).direction;
    final deltaDirecao = (direcaoEsperada - direcaoFeita).abs();

    final segmento = esperado.pontoFim! - esperado.pontoInicio!;
    double somaDistancias = 0;
    for (final p in pontos) {
      final proj = _distanciaAoSegmento(p, esperado.pontoInicio!, esperado.pontoFim!);
      somaDistancias += proj;
    }
    final mediaDistancia = somaDistancias / pontos.length;

    const toleranciaDirecao = 1.2;
    const toleranciaDistancia = 50.0;

    final passou = deltaDirecao < toleranciaDirecao && mediaDistancia < toleranciaDistancia;

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
      tracoAtual = 0;
      pontuacao = 0;
    });
  }

  void _novoKanji() {
    setState(() {
      pontos.clear();
      mensagem = '';
      tracoAtual = 0;
      pontuacao = 0;
    });
    // Aqui você poderia chamar um callback para sortear um novo kanji se necessário
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

            if (_verificarTraco(inicio, fim)) {
              setState(() {
                tracoAtual++;
                pontuacao += 10;
                mensagem = "✅ Traço $tracoAtual correto! Pontuação: $pontuacao";
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
    final terminou = tracoAtual >= widget.kanji.tracos.length;

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
            if (terminou)
              ElevatedButton.icon(
                onPressed: _novoKanji,
                icon: const Icon(Icons.autorenew),
                label: const Text('Novo Kanji'),
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

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < tracos.length; i++) {
      final t = tracos[i];
      final paintGuia = Paint()
        ..color = i < tracoAtual
            ? Colors.green
            : (modoAltoContraste ? Colors.yellow : Colors.grey.shade300)
        ..strokeWidth = 8
        ..strokeCap = StrokeCap.round;

      if (t.pontoInicio != null && t.pontoFim != null) {
        canvas.drawLine(t.pontoInicio!, t.pontoFim!, paintGuia);
      }
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