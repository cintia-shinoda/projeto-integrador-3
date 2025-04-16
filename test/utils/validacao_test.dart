import 'package:flutter_test/flutter_test.dart';
import 'package:kanji_app/utils/validacao.dart';

void main() {
  group('Função camposPreenchidos', () {
    test('retorna true se email e senha forem preenchidos', () {
      final resultado = camposPreenchidos('teste@email.com', '123456');
      expect(resultado, true);
    });

    test('retorna false se o email estiver vazio', () {
      final resultado = camposPreenchidos('', '123456');
      expect(resultado, false);
    });

    test('retorna false se a senha estiver vazia', () {
      final resultado = camposPreenchidos('teste@email.com', '');
      expect(resultado, false);
    });

    test('retorna false se ambos estiverem vazios', () {
      final resultado = camposPreenchidos('', '');
      expect(resultado, false);
    });
  });
}