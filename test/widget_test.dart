import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanji_app/main.dart';

void main() {  //testa se a splash screen navega para a tela de login após 2 segundos
  testWidgets('Splash screen navega para login após 2s', (WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());

  // Aguarda o Future.delayed terminar
  await tester.pump(const Duration(seconds: 3));
  await tester.pumpAndSettle();

  expect(find.text('Login'), findsOneWidget); 
});
}