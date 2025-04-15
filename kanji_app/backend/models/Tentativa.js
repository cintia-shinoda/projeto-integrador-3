const mongoose = require('mongoose');

const tentativaSchema = new mongoose.Schema({
  data: { type: Date, default: Date.now },
  acertou: Boolean,
  usuario_id: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  kanji_id: { type: mongoose.Schema.Types.ObjectId, ref: 'Kanji' }, // sorteado
  palavra_id: { type: mongoose.Schema.Types.ObjectId, ref: 'Palavra' } // opcional
});

module.exports = mongoose.model('Tentativa', tentativaSchema);
