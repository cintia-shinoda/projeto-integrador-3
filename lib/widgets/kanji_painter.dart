import 'package:flutter/material.dart';

class KanjiPainterWidget extends StatefulWidget {
  const KanjiPainterWidget({super.key});

  @override
  State<KanjiPainterWidget> createState() => _KanjiPainterWidgetState();
}

class _KanjiPainterWidgetState extends State<KanjiPainterWidget> {
  List<Offset> pontos = [];

  void _limpar() {
    setState(() {
      pontos.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                RenderBox box = context.findRenderObject() as RenderBox;
                Offset localPosition = box.globalToLocal(details.globalPosition);
                pontos.add(localPosition);
              });
            },
            onPanEnd: (_) {
              pontos.add(Offset.zero); // separador de traços
            },
            child: CustomPaint(
              painter: _KanjiPainter(pontos),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Container(color: Colors.white),
              ),
            ),
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

class _KanjiPainter extends CustomPainter {
  final List<Offset> pontos;

  _KanjiPainter(this.pontos);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < pontos.length - 1; i++) {
      if (pontos[i] != Offset.zero && pontos[i + 1] != Offset.zero) {
        canvas.drawLine(pontos[i], pontos[i + 1], paint);
      }
    }

    // Debug para garantir que está pintando
    print('🎨 Desenhando ${pontos.length} pontos');
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}