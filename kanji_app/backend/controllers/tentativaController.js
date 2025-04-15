const Tentativa = require('../models/Tentativa');
const Kanji = require('../models/Kanji');
const User = require('../models/User');

const criarTentativa = async (req, res) => {
  try {
    const { usuario_id, palavra_id, acertou } = req.body;

    // Sorteia um kanji aleatório
    const count = await Kanji.countDocuments();
    const random = Math.floor(Math.random() * count);
    const kanji = await Kanji.findOne().skip(random);

    // Cria a tentativa
    const tentativa = new Tentativa({
      usuario_id,
      palavra_id,
      kanji_id: kanji._id,
      acertou
    });

    await tentativa.save();

    // Calcula a pontuação
    let pontos = 0;
    if (acertou) {
      pontos += 10;
      if (palavra_id) pontos += 5;
    }

    // Atualiza a pontuação do usuário e retorna o novo valor
    const updatedUser = await User.findByIdAndUpdate(
      usuario_id,
      { $inc: { pontuacao: pontos } },
      { new: true }
    );

    // Resposta completa
    res.status(201).json({
      message: 'Tentativa registrada com sucesso!',
      pontos_ganhos: pontos,
      pontuacao_total: updatedUser.pontuacao,
      tentativa
    });

  } catch (error) {
    console.error('Erro ao registrar tentativa:', error);
    res.status(500).json({ error: error.message });
  }
};

module.exports = {
  criarTentativa
};