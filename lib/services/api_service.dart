import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/kanji.dart';
import '../models/usuario.dart';
import 'dart:io';

class ApiService {
  // static final String baseUrl = Platform.isMacOS
  //   ? 'http://192.168.0.12:3000/api'
  //   : 'http://localhost:3000/api';
  static const String baseUrl = 'https://kanji-backend-kbhr.onrender.com/api';

  // Login
  static Future<Usuario?> login(String email, String senha) async {
    final response = await http.post(
      Uri.parse('$baseUrl/usuarios/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'senha': senha}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['usuario'];
      return Usuario.fromJson(data);
    } else {
      return null;
    }
  }

  // Registro
  static Future<bool> register(String nome, String email, String senha) async {
    final response = await http.post(
      Uri.parse('$baseUrl/usuarios/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nome': nome,
        'email': email,
        'senha': senha,
      }),
    );

    return response.statusCode == 201;
  }

  // Obter kanji aleatório
  static Future<Kanji?> getKanjiAleatorio() async {
    final response = await http.get(Uri.parse('$baseUrl/kanjis/aleatorio'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Kanji.fromJson(data);
    } else {
      return null;
    }
  }

  // Registrar tentativa
  static Future<bool> registrarTentativa({
    required String usuarioId,
    bool acertou = false,
    String? palavraId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tentativas'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'usuario_id': usuarioId,
        'palavra_id': palavraId,
        'acertou': acertou,
      }),
    );

    return response.statusCode == 201;
  }

  // Obter dados de um usuário pelo ID
  static Future<Usuario?> getUsuario(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/usuarios'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      final userData = data.firstWhere(
        (user) => user['_id'] == id,
        orElse: () => null,
      );

      return userData != null ? Usuario.fromJson(userData) : null;
    } else {
      return null;
    }
  }

  // Obter ranking
  static Future<List<Usuario>> getRanking() async {
    final response = await http.get(Uri.parse('$baseUrl/usuarios'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      List<Usuario> usuarios = data.map((json) => Usuario.fromJson(json)).toList();
      usuarios.sort((a, b) => b.pontuacao.compareTo(a.pontuacao));
      return usuarios;
    } else {
      return [];
    }
  }
}
