const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const User = require('../models/User');

// Rotas REST
router.post('/', userController.criarUsuario);
router.get('/', userController.listarUsuarios);

// Rotas específicas de autenticação
router.post('/register', userController.register);
router.post('/login', userController.login);

router.patch('/:id/pontuacao', async (req, res) => {
    try {
      const user = await User.findByIdAndUpdate(
        req.params.id,
        { $inc: { pontuacao: 10 } },
        { new: true }
      );
      res.json(user);
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  });

module.exports = router;