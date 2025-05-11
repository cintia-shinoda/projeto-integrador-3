import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/usuario.dart';

class LoginScreen extends StatefulWidget {
  final bool modoAltoContraste;
  final void Function(bool) onToggleContraste;

  const LoginScreen({
    super.key,
    required this.modoAltoContraste,
    required this.onToggleContraste,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String senha = '';
  String mensagem = '';

  Future<void> _login() async {
    final usuario = await ApiService.login(email, senha);
    if (usuario != null) {
      Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: {
          'usuario': usuario,
        },
      );
    } else {
      setState(() {
        mensagem = 'Credenciais inválidas';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        actions: [
          Row(
            children: [
              const Text('Alto contraste'),
              Switch(
                value: widget.modoAltoContraste,
                onChanged: widget.onToggleContraste,
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                key: const ValueKey('emailLoginField'),
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) => email = value,
              ),
              TextFormField(
                key: const ValueKey('senhaLoginField'),
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                onChanged: (value) => senha = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                key: const ValueKey('botaoLogin'),
                onPressed: _login,
                child: const Text('Entrar'),
              ),
              const SizedBox(height: 10),
              TextButton(
                key: const ValueKey('botaoCriarConta'),
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Criar conta'),
              ),
              const SizedBox(height: 10),
              Text(
                mensagem,
                style: const TextStyle(color: Colors.red),
              )
            ],
          ),
        ),
      ),
    );
  }
}