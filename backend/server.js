const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
require('dotenv').config();

// Importar rotas
const kanjiRoutes = require('./routes/kanjiRoutes');
const palavraRoutes = require('./routes/palavraRoutes');
const tentativaRoutes = require('./routes/tentativaRoutes');
const userRoutes = require('./routes/userRoutes'); // ✅ rota de usuários

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Conectar ao MongoDB Atlas
mongoose.connect(process.env.MONGODB_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true
})
.then(() => {
  console.log('🟢 Conectado ao MongoDB');
})
  .catch(err => console.error('Erro de conexão', err));

// Usar rotas da API
app.use('/api/kanjis', kanjiRoutes);
app.use('/api/palavras', palavraRoutes);
app.use('/api/tentativas', tentativaRoutes);
app.use('/api/usuarios', userRoutes); // ✅ rota ativa

// Iniciar o servidor
const port = process.env.PORT || 3000;
app.listen(port, '0.0.0.0', () => {
  console.log(`🚀 Servidor acessível em todas as interfaces na porta ${port}`);
});


// Rota para Visualização do Status do Servidor
app.get('/', (req, res) => {
  res.send('API do App de Kanji está Rodando com Sucesso!');
});