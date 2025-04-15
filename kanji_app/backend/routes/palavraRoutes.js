const express = require('express');
const router = express.Router();
const palavraController = require('../controllers/palavraController');

// Criar nova palavra
router.post('/', palavraController.criarPalavra);

// Buscar todas as palavras
router.get('/', palavraController.listarPalavras);

// Buscar palavra por ID
router.get('/:id', palavraController.buscarPalavraPorId);

module.exports = router;