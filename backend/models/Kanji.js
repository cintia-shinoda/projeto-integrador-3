const mongoose = require('mongoose');

// Subdocumento para os traços do kanji
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
}, { _id: false }); // Impede que cada traço tenha um _id automático

// Schema principal do Kanji
const kanjiSchema = new mongoose.Schema({
  leitura: String,
  traducao: String,
  leitura_kun: String,
  leitura_on: String,
  tracos: [tracoSchema]
});

module.exports = mongoose.model('Kanji', kanjiSchema);