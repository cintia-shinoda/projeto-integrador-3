const Palavra = require('../models/Palavra');

const criarPalavra = async (req, res) => {
  try {
    const palavra = await Palavra.create(req.body);
    res.status(201).json(palavra);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

const listarPalavras = async (req, res) => {
  try {
    const palavras = await Palavra.find();
    res.json(palavras);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

const buscarPalavraPorId = async (req, res) => {
  try {
    const palavra = await Palavra.findById(req.params.id);
    if (palavra) res.json(palavra);
    else res.status(404).json({ error: 'Palavra não encontrada' });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

module.exports = {
  criarPalavra,
  listarPalavras,
  buscarPalavraPorId
};