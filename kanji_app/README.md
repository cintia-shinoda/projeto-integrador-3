# Kanji App

## Tecnologias Utilizadas
- Front-End: Dart (Framework: Flutter)
- Back-End: JavaScript (Framework: Node.js (Express))
- Banco de Dados: MongoDB
- Controle de Versão: Git/GitHub
- Testes: Postman
- IDE: Visual Studio Code
- Integração Contínua: GitHub Actions
<!-- - API: RESTful -->
<!-- - Deploy: Render, Heroku ou Railway -->
<!-- - Acessibilidade: Flutter Colorblind ou Flutter Accessibility -->



## Estrutura do Projeto
```bash
├── android/     # projeto Android
│
├── assets/      # arquivos estáticos (imagens, fontes, etc.)
│   ├── logo.png
│
├── backend/     # API em Node.js
│   ├── controllers/
│   │   ├── kanjiController.js
│   │   ├── palavraController.js
│   │   ├── tentativaController.js
│   │   ├── userController.js
│   │     
│   ├── models/         # Modelos de dados
│   │   ├── Kanji.js
│   │   ├── Palavra.js
│   │   ├── Tentativa.js
│   │   ├── User.js
│   │
│   ├── routes/         # Rotas da API
│   │   ├── kanjiRoutes.js
│   │   ├── palavraRoutes.js
│   │   ├── tentativaRoutes.js
│   │   ├── userRoutes.js
│   │
│   ├── .env            # Arquivo de variáveis de ambiente
│   ├── package-lock.json 
│   ├── package.json    # Arquivo de dependências
│   ├── server.js       # Arquivo principal da API
│
├── build/       # Arquivos de build do Flutter
│
├── ios/         # projeto iOS (Swift)
│
├── lib/         # Código fonte do aplicativo Flutter
│   ├── models/
│   │   ├── kanji.dart
│   │   ├── palavra.dart
│   │   ├── tentativa.dart
│   │   ├── usuario.dart
│   │
│   ├── screens/        # Telas do aplicativo
│   │   ├── home_screen.dart
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   ├── splash_screen.dart
│   │   ├── test_screen.dart
│   │
│   ├── services/        # Serviços de API
│   │   ├── api_service.dart  # Conexão com a API
│   │
│   ├── widgets/
│   │   ├── kanji_painter.dart
│   │   ├── kanji_tracing_game.dart
│   │
│   ├── main.dart             # Ponto de entrada do aplicativo
│
├── linux/      # projeto Linux
│
├── macos/      # projeto MacOS
│
├── test/       # Testes
│    
├── web/        # projeto Web
│
├── windows/    # projeto Windows
│
├── .gitignore  # Pastas e arquivos a serem ignorados pelo Git
│
├── analysis_options.yaml   # Configurações de análise do Dart
│
├── kanji_app.iml     # Configuração do projeto
│
├── pubspec.lock      # Arquivo de bloqueio de dependências
│
├── pubspec.yaml      # Arquivo de dependências do Flutter
│
├── README.md         # Documentação do projeto
```


<!-- ## Screens
- [x] Splash Screen
- [x] Login
- [x] Cadastro
- [ ] Tela Inicial (Quiz) -->

<!-- - [ ] Tela do Perfil
- [ ] Tela para escolha de nível -->

<!-- ## Plataformas -->