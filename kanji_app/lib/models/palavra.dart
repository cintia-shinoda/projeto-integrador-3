class Palavra {
  final String id;
  final String palavra;
  final String leitura;
  final String traducao;
  final String nivel;

  Palavra({
    required this.id,
    required this.palavra,
    required this.leitura,
    required this.traducao,
    required this.nivel,
  });

  factory Palavra.fromJson(Map<String, dynamic> json) {
    return Palavra(
      id: json['_id'],
      palavra: json['palavra'],
      leitura: json['leitura'],
      traducao: json['traducao'],
      nivel: json['nivel'],
    );
  }
}