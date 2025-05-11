import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'models/usuario.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool modoAltoContraste = false;

  void toggleContraste(bool value) {
    setState(() {
      modoAltoContraste = value;
    });
  }

  final ThemeData temaNormal = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
  );

  final ThemeData temaAltoContraste = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.yellow),
      bodyMedium: TextStyle(color: Colors.yellow),
      labelLarge: TextStyle(color: Colors.yellow),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.yellow,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStatePropertyAll(Colors.yellow),
      trackColor: MaterialStatePropertyAll(Colors.grey),
    ),
  );

  @override
  Widget build(BuildContext context) {
    // ✅ Detecção de ambiente de teste
    final bool isTest = const bool.fromEnvironment('FLUTTER_TEST');

    return MaterialApp(
      title: 'Kanji App',
      theme: modoAltoContraste ? temaAltoContraste : temaNormal,
      initialRoute: isTest ? '/login' : '/', // ✅ pula a splash no teste
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (_) => const SplashScreen());
        } else if (settings.name == '/login') {
          return MaterialPageRoute(
            builder: (_) => LoginScreen(
              modoAltoContraste: modoAltoContraste,
              onToggleContraste: toggleContraste,
            ),
          );
        } else if (settings.name == '/register') {
          return MaterialPageRoute(
            builder: (_) => RegisterScreen(
              modoAltoContraste: modoAltoContraste,
              onToggleContraste: toggleContraste,
            ),
          );
        } else if (settings.name == '/home') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => HomeScreen(
              usuario: args['usuario'],
              modoAltoContraste: modoAltoContraste,
              onToggleContraste: toggleContraste,
            ),
          );
        }
        return null;
      },
    );
  }
}