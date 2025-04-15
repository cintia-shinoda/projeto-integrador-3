const express = require('express');
const router = express.Router();
const tentativaController = require('../controllers/tentativaController');

// ✅ Usa o controller com sorteio e pontuação
router.post('/', tentativaController.criarTentativa);

// Buscar tentativas de um usuário
router.get('/usuario/:usuarioId', async (req, res) => {
  const Tentativa = require('../models/Tentativa');
  try {
    const tentativas = await Tentativa.find({ usuario_id: req.params.usuarioId });
    res.json(tentativas);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;