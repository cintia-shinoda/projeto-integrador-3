const User = require('../models/User');

// Criar novo usuário (register)
const register = async (req, res) => {
  try {
    const { nome, email, senha } = req.body;

    // Verifica se já existe um usuário com esse e-mail
    const userExists = await User.findOne({ email });
    if (userExists) {
      return res.status(400).json({ error: 'Email já cadastrado' });
    }

    const novoUsuario = new User({ nome, email, senha });
    await novoUsuario.save();

    res.status(201).json({ message: 'Usuário cadastrado com sucesso!', usuario: novoUsuario });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


// Autenticação (login)
const login = async (req, res) => {
  try {
    const { email, senha } = req.body;

    const usuario = await User.findOne({ email, senha });

    if (!usuario) {
      return res.status(401).json({ error: 'Credenciais inválidas' });
    }

    res.json({
      message: 'Login realizado com sucesso!',
      usuario: {
        id: usuario._id,
        nome: usuario.nome,
        email: usuario.email,
        pontuacao: usuario.pontuacao
      }
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const criarUsuario = async (req, res) => {
  const { nome, email, senha } = req.body;
  const novo = new User({ nome, email, senha });
  await novo.save();
  res.status(201).json(novo);
};

const listarUsuarios = async (req, res) => {
  try {
    console.log("📥 Requisição recebida: listar usuários");
    const usuarios = await User.find();
    res.json(usuarios);
  } catch (error) {
    console.log("❌ Erro ao listar usuários:", error);
    res.status(500).json({ error: error.message });
  }
};

module.exports = {
  criarUsuario,
  listarUsuarios,
  register,
  login
};