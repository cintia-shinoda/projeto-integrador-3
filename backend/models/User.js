const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  nome: { type: String, required: true },
  email: { type: String, unique: true, required: true },
  senha: {type: String, required: true },
  kanjis_aprendidos: [{ type: String}],
  palavras_aprendidas: [{ type: String}],
  pontuacao: { type: Number, default: 0 }
}, {
  timestamps: true
});

module.exports = mongoose.model('User', userSchema);