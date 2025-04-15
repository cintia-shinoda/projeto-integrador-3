// lib/models/usuario.dart

class Usuario {
  final String id;
  final String nome;
  final String email;
  final int pontuacao;

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.pontuacao,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['_id'] ?? '',
      nome: json['nome'] ?? '',
      email: json['email'] ?? '',
      pontuacao: json['pontuacao'] ?? 0,
    );
  }
}
