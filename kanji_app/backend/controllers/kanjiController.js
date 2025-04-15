const Kanji = require('../models/Kanji');

// Retorna um kanji aleatório
const getKanjiAleatorio = async (req, res) => {
  try {
    const count = await Kanji.countDocuments();
    const random = Math.floor(Math.random() * count);
    const kanji = await Kanji.findOne().skip(random);
    res.json(kanji);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Cria um novo kanji
const criarKanji = async (req, res) => {
  try {
    const novoKanji = new Kanji(req.body);
    await novoKanji.save();
    res.status(201).json(novoKanji);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Lista todos os kanjis
const listarKanjis = async (req, res) => {
  try {
    const kanjis = await Kanji.find();
    res.json(kanjis);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Buscar kanji por ID
const buscarKanjiPorId = async (req, res) => {
  try {
    const kanji = await Kanji.findById(req.params.id);
    if (kanji) res.json(kanji);
    else res.status(404).json({ error: 'Kanji não encontrado' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = {
  getKanjiAleatorio,
  criarKanji,
  listarKanjis,
  buscarKanjiPorId
};