import 'package:flutter/material.dart';
import 'dart:math';

class Traco {
  final Offset inicio;
  final Offset fim;

  Traco({required this.inicio, required this.fim});
}

class KanjiTracingGame extends StatefulWidget {
  const KanjiTracingGame({super.key});

  @override
  State<KanjiTracingGame> createState() => _KanjiTracingGameState();
}

class _KanjiTracingGameState extends State<KanjiTracingGame> {
  List<Offset> pontos = [];
  int tracoAtual = 0;
  String mensagem = '';

  final List<Traco> tracosEsperados = [
  Traco(inicio: Offset(40, 150), fim: Offset(340, 150)),
];

  void _limpar() {
    setState(() {
      pontos.clear();
      tracoAtual = 0;
      mensagem = '';
    });
  }

  bool _verificarTraco(Offset inicio, Offset fim) {
    const double tolerancia = 40;
    Traco esperado = tracosEsperados[tracoAtual];

    bool inicioCorreto = (inicio - esperado.inicio).distance < tolerancia;
    bool fimCorreto = (fim - esperado.fim).distance < tolerancia;

    return inicioCorreto && fimCorreto;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: Container(
            color: Colors.white,
            child: GestureDetector(
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
                    mensagem = '✅ Traço ${tracoAtual} correto!';
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
                painter: _KanjiGamePainter(pontos, tracosEsperados, tracoAtual),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                ),
              ),
            ),
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
            onPressed: _limpar,
            icon: const Icon(Icons.refresh),
            label: const Text('Limpar'),
          ),
        )
      ],
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
      print('🎨 Desenhando traço ${i + 1}: ${tracos[i].inicio} → ${tracos[i].fim}');
      canvas.drawLine(tracos[i].inicio, tracos[i].fim, paintGuia);
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
