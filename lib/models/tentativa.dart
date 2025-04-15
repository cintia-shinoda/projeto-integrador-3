class Tentativa {
  final String id;
  final String usuarioId;
  final String? kanjiId;
  final String? palavraId;
  final bool acertou;
  final DateTime data;

  Tentativa({
    required this.id,
    required this.usuarioId,
    this.kanjiId,
    this.palavraId,
    required this.acertou,
    required this.data,
  });

  factory Tentativa.fromJson(Map<String, dynamic> json) {
    return Tentativa(
      id: json['_id'],
      usuarioId: json['usuario_id'],
      kanjiId: json['kanji_id'],
      palavraId: json['palavra_id'],
      acertou: json['acertou'],
      data: DateTime.parse(json['data']),
    );
  }
}