import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kanji_app/main.dart' as app;
import 'package:flutter/material.dart';


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Diagnóstico visual da tela inicial', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Lista os widgets visíveis no terminal
    final allWidgets = find.byType(Widget);
    final widgetCount = tester.widgetList(allWidgets).length;
    print('🧪 Total de widgets na tela inicial: $widgetCount');

    // Verifica se o botão está visível
    final botaoCriarConta = find.byKey(const ValueKey('botaoCriarConta'));
    if (tester.any(botaoCriarConta)) {
      print('✅ Botão Criar Conta ENCONTRADO');
    } else {
      print('❌ Botão Criar Conta NÃO encontrado');
    }

    // Mostra todos os textos na tela
    final textos = find.byType(Text);
    for (final widget in tester.widgetList(textos)) {
      final texto = widget as Text;
      print('🔤 Texto encontrado: "${texto.data}"');
    }
  });
}