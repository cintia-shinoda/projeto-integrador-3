import 'package:flutter/material.dart';
import 'dart:math';
import '../models/kanji.dart';
import '../services/api_service.dart';

class KanjiTracingGame extends StatefulWidget {
  const KanjiTracingGame({super.key});

  @override
  State<KanjiTracingGame> createState() => _KanjiTracingGameState();
}

class _KanjiTracingGameState extends State<KanjiTracingGame> {
  List<Offset> pontos = [];
  int tracoAtual = 0;
  String mensagem = '';
  Kanji? kanji;

  @override
  void initState() {
    super.initState();
    _carregarKanji();
  }

  Future<void> _carregarKanji() async {
    final resultado = await ApiService.getKanjiAleatorio();
    if (resultado != null) {
      setState(() {
        kanji = resultado;
        tracoAtual = 0;
        pontos.clear();
        mensagem = '';
      });
    } else {
      setState(() {
        mensagem = 'Erro ao carregar kanji';
      });
    }
  }

  bool _verificarTraco(Offset inicio, Offset fim) {
    const double tolerancia = 40;
    if (kanji == null || tracoAtual >= kanji!.tracos.length) return false;
    final esperado = kanji!.tracos[tracoAtual];
    if (esperado.pontoInicio == null || esperado.pontoFim == null) return false;
    bool inicioCorreto = (inicio - esperado.pontoInicio!).distance < tolerancia;
    bool fimCorreto = (fim - esperado.pontoFim!).distance < tolerancia;
    return inicioCorreto && fimCorreto;
  }

  void _limpar() {
    setState(() {
      pontos.clear();
      tracoAtual = 0;
      mensagem = '';
    });
  }

  Widget _buildGestureCanvas() {
    return GestureDetector(
      onPanStart: (details) {
        RenderBox box = context.findRenderObject() as RenderBox;
        Offset local = box.globalToLocal(details.globalPosition);
        pontos = [local];
      },
      onPanUpdate: (details) {
        RenderBox box = context.findRenderObject() as RenderBox;
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
        painter: _KanjiGamePainter(pontos, kanji!.tracos, tracoAtual),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            const Text("Treino de Kanji", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Pontuação: 0", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text(kanji?.leitura ?? '', style: const TextStyle(fontSize: 40)),
            Text(kanji?.traducao ?? '', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            SizedBox(
              height: 300,
              child: Container(
                color: Colors.white,
                child: kanji == null
                    ? const Center(child: CircularProgressIndicator())
                    : _buildGestureCanvas(),
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
                ElevatedButton.icon(
                  onPressed: _carregarKanji,
                  icon: const Icon(Icons.autorenew),
                  label: const Text('Novo Kanji'),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _KanjiGamePainter extends CustomPainter {
  final List<Offset> pontos;
  final List<Traco> tracos;
  final int tracoAtual;

  _KanjiGamePainter(this.pontos, this.tracos, this.tracoAtual);

  @override
  void paint(Canvas canvas, Size size) {
    final paintGuia = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    for (int i = tracoAtual; i < tracos.length; i++) {
      final t = tracos[i];
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