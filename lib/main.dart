import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
// import 'screens/test_screen.dart'; // usado apenas em desenvolvimento

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kanji App',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(), // agora a splash personalizada
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        // '/test': (context) => const TestScreen(), // opcional
      },
    );
  }
}