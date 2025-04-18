import 'dart:ui';

class Traco {
  final int ordem;
  final String svg;
  final Offset pontoInicio;
  final Offset pontoFim;

  Traco({
    required this.ordem,
    required this.svg,
    required this.pontoInicio,
    required this.pontoFim,
  });

  factory Traco.fromJson(Map<String, dynamic> json) {
    return Traco(
      ordem: json['ordem'],
      svg: json['svg'],
      pontoInicio: Offset(
        json['ponto_inicio']['x'].toDouble(),
        json['ponto_inicio']['y'].toDouble(),
      ),
      pontoFim: Offset(
        json['ponto_fim']['x'].toDouble(),
        json['ponto_fim']['y'].toDouble(),
      ),
    );
  }
}

class Kanji {
  final String leitura;
  final String traducao;
  final String leituraKun;
  final String leituraOn;
  final List<Traco> tracos;

  Kanji({
    required this.leitura,
    required this.traducao,
    required this.leituraKun,
    required this.leituraOn,
    required this.tracos,
  });

  factory Kanji.fromJson(Map<String, dynamic> json) {
    return Kanji(
      leitura: json['leitura'],
      traducao: json['traducao'],
      leituraKun: json['leitura_kun'],
      leituraOn: json['leitura_on'],
      tracos: (json['tracos'] as List)
          .map((t) => Traco.fromJson(t))
          .toList(),
    );
  }
}