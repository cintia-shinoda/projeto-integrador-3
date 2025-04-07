import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:3000';

  static Future<String> cadastrar(String nome, String email, String senha) async {
    final url = Uri.parse('$baseUrl/register');
    final resposta = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nome': nome, 'email': email, 'senha': senha}),
    );

    if (resposta.statusCode == 200) {
      return 'Cadastro bem-sucedido!';
    } else {
      final erro = jsonDecode(resposta.body)['error'];
      return 'Erro: $erro';
    }
  }

  static Future<String> login(String email, String senha) async {
    final url = Uri.parse('$baseUrl/login');
    final resposta = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'senha': senha}),
    );

    if (resposta.statusCode == 200) {
      final dados = jsonDecode(resposta.body);
      return 'Bem-vindo, ${dados['nome']}!';
    } else {
      final erro = jsonDecode(resposta.body)['error'];
      return 'Erro: $erro';
    }
  }
}