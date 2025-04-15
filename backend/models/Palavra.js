const mongoose = require('mongoose');

const palavraSchema = new mongoose.Schema({
  palavra: String,
  leitura: String,
  traducao: String,
  nivel: String,
  kanjis: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Kanji' }]
});

module.exports = mongoose.model('Palavra', palavraSchema);
