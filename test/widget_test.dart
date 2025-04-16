import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanji_app/main.dart';

void main() {
  // testWidgets('Verifica se o app carrega corretamente', (WidgetTester tester) async {
  //   await tester.pumpWidget(const MyApp());

  //   // Verifica se existe algum texto ou widget da tela inicial
  //   expect(find.byType(MaterialApp), findsOneWidget);
  // });
  testWidgets('Splash screen navega para login após 2s', (WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());

  // Aguarda o Future.delayed terminar
  await tester.pump(const Duration(seconds: 3));
  await tester.pumpAndSettle();

  expect(find.text('Login'), findsOneWidget); // ou outra verificação adequada
});
}