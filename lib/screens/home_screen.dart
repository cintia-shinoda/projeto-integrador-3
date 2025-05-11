import 'package:flutter/material.dart';
import '../models/kanji.dart';
import '../models/usuario.dart';
import '../services/api_service.dart';
import '../widgets/kanji_tracing_game.dart';

class HomeScreen extends StatefulWidget {
  final Usuario usuario;
  final bool modoAltoContraste;
  final void Function(bool) onToggleContraste;

  const HomeScreen({
    super.key,
    required this.usuario,
    required this.modoAltoContraste,
    required this.onToggleContraste,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Kanji? kanjiAtual;
  String mensagem = '';
  bool carregando = false;
  int pontuacao = 0;

  @override
  void initState() {
    super.initState();
    pontuacao = widget.usuario.pontuacao;
    _sortearKanji();
  }

  Future<void> _sortearKanji() async {
    setState(() {
      carregando = true;
      mensagem = '';
    });

    final kanji = await ApiService.getKanjiAleatorio();
    setState(() {
      kanjiAtual = kanji;
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Text('Alto contraste'),
              ),
              Switch(
                value: widget.modoAltoContraste,
                onChanged: widget.onToggleContraste,
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: carregando
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  if (kanjiAtual != null)
                    Column(
                      children: [
                        Text(
                          kanjiAtual!.traducao,
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Leitura on: ${kanjiAtual!.leituraOn}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Leitura kun: ${kanjiAtual!.leituraKun}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  if (kanjiAtual != null)
                    Expanded(
                      child: KanjiTracingGame(
                        modoAltoContraste: widget.modoAltoContraste,
                        kanji: kanjiAtual!,
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
                ],
              ),
      ),
    );
  }
}