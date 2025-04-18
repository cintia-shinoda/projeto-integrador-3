const express = require('express');
const router = express.Router();
const kanjiController = require('../controllers/kanjiController');

// Criar novo kanji (POST/
router.post('/', kanjiController.criarKanji);

// Listar todos os kanjis (GET/)
router.get('/', kanjiController.listarKanjis);

// Sortear kanji aleatório (GET/)
router.get('/aleatorio', kanjiController.getKanjiAleatorio);

// Buscar kanji por ID (GET)
router.get('/:id', kanjiController.buscarKanjiPorId);

module.exports = router;