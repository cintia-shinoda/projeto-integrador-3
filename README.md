# Projeto Integrador em Computação III

[![Workflow Flutter CI](https://github.com/cintia-shinoda/projeto-integrador-3/actions/workflows/flutter_ci.yml/badge.svg)](https://github.com/cintia-shinoda/projeto-integrador-3/actions/workflows/flutter_ci.yml)

## Tema do PI
Desenvolver um software com framework web ou aplicativo que utilize banco de dados, inclua script web (Javascript), nuvem, acessibilidade, controle de versão, integração contínua e testes. 
Incluir um dos seguintes requisitos: uso e fornecimento de API, análises de dados e IoT.


## Descrição do Projeto
- App Mobile em Flutter
- Treino interativo de Kanji


## Tecnologias Utilizadas e Funcionalidades
- Front-End: Dart (Framework: Flutter)
- Back-End: JavaScript (Framework: Node.js (Express))
- Banco de Dados: MongoDB Atlas
- Controle de Versão: Git/GitHub
- Testes: Postman
- IDE: Visual Studio Code
- Integração Contínua: GitHub Actions
- Acessibilidade: Alto Contraste

<!-- - API: RESTful -->
<!-- - Deploy: Render, Heroku ou Railway -->
<!-- - Acessibilidade: Flutter Colorblind ou Flutter Accessibility -->



## Estrutura do Projeto
```bash
├── .github/  
│   ├── workflows/
│   │   ├── flutter_ci.yml  # Fluxo de Integração Contínua
│
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
│   ├── utils/
│   │   ├── validacao.dart
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
│   ├── utils/
│   │   ├── validacao_test.dart
│   ├── widget_test.dart
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

---


## Diagramas e Modelos do Projeto:

### Persona
https://miro.com/app/board/uXjVIDg6SCs=/?share_link_id=872062743520

### Protótipo de Telas
https://miro.com/app/board/uXjVIDg8nKU=/?share_link_id=804776781847

### Kanban
https://miro.com/app/board/uXjVIDCvAew=/?share_link_id=348821158940

### UML Use Case Diagram
https://miro.com/app/board/uXjVIDg6SAY=/?share_link_id=118356666999

### Arquitetura
https://miro.com/app/board/uXjVIAmW3ZQ=/?share_link_id=480632220145

### Modelo Entidade-Relacionamento (MER)
https://miro.com/app/board/uXjVID-LilI=/?share_link_id=160092579356



<!-- -----------------------------------
### Clonar o projeto do GitHub
```bash
git clone https://github.com/cintia-shinoda/projeto-integrador-3.git

cd projeto-integrador-3
```

### Back-End
```bash
cd backend

node server.js
```

### Front-End
```bash
flutter run
``` -->