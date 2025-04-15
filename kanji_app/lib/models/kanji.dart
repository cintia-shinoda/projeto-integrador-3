class Kanji {
  final String id;
  final String leitura;
  final String traducao;
  final String leituraKun;
  final String leituraOn;

  Kanji({
    required this.id,
    required this.leitura,
    required this.traducao,
    required this.leituraKun,
    required this.leituraOn,
  });

  factory Kanji.fromJson(Map<String, dynamic> json) {
    return Kanji(
      id: json['_id'],
      leitura: json['leitura'],
      traducao: json['traducao'],
      leituraKun: json['leitura_kun'],
      leituraOn: json['leitura_on'],
    );
  }
}