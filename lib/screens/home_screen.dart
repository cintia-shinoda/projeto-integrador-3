// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../models/kanji.dart';
import '../models/usuario.dart';
import '../services/api_service.dart';
import '../widgets/kanji_tracing_game.dart';

class HomeScreen extends StatefulWidget {
  final Usuario usuario;

  const HomeScreen({super.key, required this.usuario});

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

  Future<void> _registrarTentativa(bool acertou) async {
    setState(() {
      carregando = true;
    });

    final sucesso = await ApiService.registrarTentativa(
      usuarioId: widget.usuario.id,
      palavraId: null,
      acertou: acertou,
    );

    if (sucesso) {
      setState(() {
        pontuacao += acertou ? 10 : 0;
        mensagem = acertou ? '✅ Muito bem!' : '❌ Continue tentando!';
      });
    } else {
      setState(() {
        mensagem = 'Erro ao registrar tentativa.';
      });
    }

    await Future.delayed(const Duration(milliseconds: 800));
    _sortearKanji();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Treino de Kanji')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: carregando
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Text('Pontuação: $pontuacao',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 20),
                  
                  const SizedBox(height: 10),
                  const Expanded(child: KanjiTracingGame()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _registrarTentativa(true),
                        icon: const Icon(Icons.check),
                        label: const Text('Acertei'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _registrarTentativa(false),
                        icon: const Icon(Icons.close),
                        label: const Text('Errei'),
                      ),
                    ],
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
