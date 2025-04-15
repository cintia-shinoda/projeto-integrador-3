const express = require('express');
const router = express.Router();
const kanjiController = require('../controllers/kanjiController');

// Criar novo kanji
router.post('/', kanjiController.criarKanji);

// Buscar todos os kanjis
router.get('/', kanjiController.listarKanjis);

// Buscar kanji Aleatório
router.get('/aleatorio', kanjiController.getKanjiAleatorio);

// Buscar kanji por ID
router.get('/:id', kanjiController.buscarKanjiPorId);

module.exports = router;