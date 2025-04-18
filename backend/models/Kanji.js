const mongoose = require('mongoose');

const tracoSchema = new mongoose.Schema({
  ordem: Number,
  svg: String,
  ponto_inicio: {
    x: Number,
    y: Number
  },
  ponto_fim: {
    x: Number,
    y: Number
  }
}, { _id: false });

const kanjiSchema = new mongoose.Schema({
  leitura: String,
  traducao: String,
  leitura_kun: String,
  leitura_on: String,
  tracos: [tracoSchema]
}, {
  collection: 'kanjis'
});

module.exports = mongoose.model('Kanji', kanjiSchema);