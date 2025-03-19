# Projeto Integrador em Computação III

<!-- # Integrantes -->

## Tema do PI
Desenvolver um software com framework web ou aplicativo que utilize banco de dados, inclua script web (Javascript), nuvem, acessibilidade, controle de versão, integração contínua e testes. Incluir um dos seguintes requisitos: uso e fornecimento de API, análises de dados e IoT.

## Descrição do Projeto
- App Mobile em Flutter
- Treino interativo de escrita de Kanji

## Tecnologias Utilizadas


## Estrutura do Projeto
```bash
```


## Checklist dos Requisitos:
- [ ] Framework: Flutter (Linguagem: Dart)
- [ ] Banco de Dados: MongoDB
- [ ] JavaScript
- [ ] Nuvem
- [ ] Acessibilidade
- [x] Controle de Versão: Git/GitHub
- [ ] Integração Contínua
- [ ] Testes
- [ ] API



<!-- -------


## 1. Configuração do Ambiente
- Flutter: para desenvolvimento do app
- Dart (integrado no Flutter): linguagem de programação
- Node.js (para criar a API)
- MongoDB (banco de dados)
- IDE: Visual Studio Code
- Git: controle de versão
- Postman: para testar a API

### 1.1 Configuração do Flutter
- Após instalar o Flutter, verifique:
```bash
flutter doctor
```

- Criação do projeto Flutter:
```bash
flutter create kanji_game
cd kanji_game
```

### 1.2 Instalação do MongoDB
- Instalação na Nuvem:
    - Acesse MongoDB Atlas
    - Crie uma conta gratuita e um "cluster" (banco de dados)
    - Copie a string de conexão


## 2. Criando a API com Node.js e Express
### 2.1 Criar Diretório da API
```bash
mkdir server
cd server
```

### 2.2 Iniciar um projeto Node.js
```bash
npm init -y
```

### 2.3 Instalar Dependências
```bash
npm install express mongoose cors dotenv jsonwebtoken bcryptjs

# express: Framework para criar a  API
# mongoose: Conexão com MongoDB
# cors: Permite que o Flutter acesse a API
# dotenv: Gerencia variáveis de ambiente
# jsonwebtoken: Autenticação de usuários
# bcryptjs: Criptografia de senhas
```

### 2.4 Criar arquivo index.js

```javascript
// server/index.js

const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
require("dotenv").config();

const app = express();
app.use(express.json());
app.use(cors());

mongoose.connect(process.env.MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true
}).then(() => console.log("MongoDB conectado"))
.catch(err => console.log(err));

app.get("/", (req, res) => res.send("API funcionando!"));

app.listen(5000, () => console.log("Servidor rodando na porta 5000"));
```

- crie um arquivo .env
```javascript
MONGO_URI=mongodb+srv://usuario:senha@cluster.mongodb.net/kanji_game
JWT_SECRET=sua_chave_secreta
```

Rode o servidor:
```bash
node index.js
```


## 3. Criando o App Flutter

```yaml
# no arquivo kanji_game/pubspec.yaml
  flutter:
    sdk: flutter
  http: ^0.13.3
  provider: ^6.0.0
  shared_preferences: ^2.0.5
  flutter_colorblind: ^0.2.1 # Acessibilidade para daltônicos
```

- rode:
```bash
flutter pub get
```

### 3.1 Criar a tela de login
```dart
// lib/screens/login.dart
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    // Conectar com API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(controller: emailController, decoration: InputDecoration(labelText: "E-mail")),
          TextField(controller: passwordController, obscureText: true, decoration: InputDecoration(labelText: "Senha")),
          ElevatedButton(onPressed: login, child: Text("Entrar")),
        ],
      ),
    );
  }
}
```

### 3.2 Criar a tela do jogo
```dart
// lib/screens/game.dart
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Aqui será o jogo!")),
    );
  }
}
```

## 4. Testes e Integração Contínua
### 4.1 Criar testes
```dart
// test/main_test.dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Teste simples", () {
    expect(1 + 1, 2);
  });
}
```

- rode:
```bash
flutter test
```

### 4.2 Configurar CI no GitHub
- crie um arquivo `.github/workflows/flutter.yml`
```yaml
name: Flutter CI

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test
```

## 5. Deploy
### 5.1 Subir a API na Nuvem
- Render, Heroku ou Railway

### 5.2 Gerar APK
```bash
flutter build apk
```

### 5.3 Publicar na Play Store -->