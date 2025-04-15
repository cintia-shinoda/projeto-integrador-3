// lib/screens/test_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/api_service.dart';
import '../models/usuario.dart';
import 'home_screen.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String log = '';
  Usuario? usuario;

  void _print(String msg) {
    setState(() {
      log += '$msg\n';
    });
    print(msg);
  }

  Future<void> testarCadastro() async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/usuarios/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nome': 'Cintia',
        'email': 'cintia@email.com',
        'senha': '123456',
      }),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      _print('✅ Cadastro OK');
    } else {
      _print('❌ Cadastro falhou: ${data['error'] ?? 'Erro desconhecido'}');
    }
  }

  Future<void> testarLogin() async {
  final user = await ApiService.login('cintia@email.com', '123456');
  if (user != null) {
    usuario = user;
    _print('✅ Login OK: ${user.nome}, pontuação: ${user.pontuacao}');

    // Navegar para a HomeScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(usuario: user),
      ),
    );
  } else {
    _print('❌ Login falhou');
  }
}

  Future<void> testarKanjiAleatorio() async {
    final kanji = await ApiService.getKanjiAleatorio();
    if (kanji != null) {
      _print('🈶 Kanji: ${kanji.leitura} - ${kanji.traducao}');
    } else {
      _print('❌ Erro ao buscar kanji');
    }
  }

  Future<void> testarTentativa() async {
    if (usuario == null) {
      _print('⚠️ Faça login primeiro');
      return;
    }
    final sucesso = await ApiService.registrarTentativa(
      usuarioId: usuario!.id,
      acertou: true,
    );
    _print(sucesso ? '✅ Tentativa registrada' : '❌ Tentativa falhou');
  }

  Future<void> testarUsuario() async {
    if (usuario == null) {
      _print('⚠️ Faça login primeiro');
      return;
    }
    final u = await ApiService.getUsuario(usuario!.id);
    if (u != null) {
      _print('👤 Usuário: ${u.nome}, Pontuação: ${u.pontuacao}');
    } else {
      _print('❌ Erro ao buscar usuário');
    }
  }

  Future<void> testarRanking() async {
    final ranking = await ApiService.getRanking();
    _print('🏆 Ranking:');
    for (var u in ranking) {
      _print('🔹 ${u.nome}: ${u.pontuacao}');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('🧪 TestScreen carregada!');
    return Scaffold(
      appBar: AppBar(title: const Text('Tela de Testes')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton(onPressed: testarCadastro, child: const Text('Cadastro')),
                ElevatedButton(onPressed: testarLogin, child: const Text('Login')),
                ElevatedButton(onPressed: testarKanjiAleatorio, child: const Text('Kanji Aleatório')),
                ElevatedButton(onPressed: testarTentativa, child: const Text('Registrar Tentativa')),
                ElevatedButton(onPressed: testarUsuario, child: const Text('Buscar Usuário')),
                ElevatedButton(onPressed: testarRanking, child: const Text('Ranking')),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Text(log, style: const TextStyle(fontFamily: 'monospace')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
