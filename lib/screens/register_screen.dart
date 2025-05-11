import 'package:flutter/material.dart';
import '../services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  final bool modoAltoContraste;
  final void Function(bool) onToggleContraste;

  const RegisterScreen({
    super.key,
    required this.modoAltoContraste,
    required this.onToggleContraste,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String nome = '';
  String email = '';
  String senha = '';
  String mensagem = '';

  Future<void> _registrar() async {
    final sucesso = await ApiService.register(nome, email, senha);
    if (sucesso) {
      Navigator.pop(context);
    } else {
      setState(() {
        mensagem = 'Erro ao registrar';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        actions: [
          Row(
            children: [
              const Text('Alto contraste'),
              Switch(
                value: widget.modoAltoContraste,
                onChanged: widget.onToggleContraste,
              ),
            ],
          ),
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
                key: const ValueKey('nomeField'),
                decoration: const InputDecoration(labelText: 'Nome'),
                onChanged: (value) => nome = value,
              ),
              TextFormField(
                key: const ValueKey('emailField'),
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) => email = value,
              ),
              TextFormField(
                key: const ValueKey('senhaField'),
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                onChanged: (value) => senha = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                key: const ValueKey('botaoCadastro'),
                onPressed: _registrar,
                child: const Text('Registrar'),
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