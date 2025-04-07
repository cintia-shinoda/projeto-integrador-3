const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
require('dotenv').config();

const User = require('./models/User');

const app = express();
app.use(cors());
app.use(express.json());

// Conectar ao MongoDB Atlas
mongoose.connect(process.env.MONGODB_URI)
  .then(() => console.log('🟢 Conectado ao MongoDB'))
  .catch(err => console.error('Erro de conexão', err));

// Rota de cadastro
app.post('/register', async (req, res) => {
  const { nome, email, senha } = req.body;

  const userExists = await User.findOne({ email });
  if (userExists) return res.status(400).json({ error: 'Email já cadastrado' });

  const newUser = new User({ nome, email, senha });
  await newUser.save();
  res.json({ message: 'Usuário cadastrado com sucesso!' });
});

// Rota de login
app.post('/login', async (req, res) => {
  const { email, senha } = req.body;

  const user = await User.findOne({ email, senha });
  if (!user) return res.status(401).json({ error: 'Credenciais inválidas' });

  res.json({ nome: user.nome, email: user.email });
});

// Iniciar o servidor
const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`🚀 Servidor rodando em http://localhost:${port}`);
});