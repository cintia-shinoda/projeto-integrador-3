const mongoose = require('mongoose');
const Kanji = require('../models/Kanji');
require('dotenv').config();

const kanjis = [
  {
    leitura: 'ichi',
    traducao: 'um',
    leitura_kun: 'ひと',
    leitura_on: 'イチ',
    tracos: [
      { ordem: 1, svg: 'M50,100 L250,100', ponto_inicio: { x: 50, y: 100 }, ponto_fim: { x: 250, y: 100 } }
    ]
  },
  {
    leitura: 'ni',
    traducao: 'dois',
    leitura_kun: 'ふた',
    leitura_on: 'ニ',
    tracos: [
      { ordem: 1, svg: 'M50,80 L250,80', ponto_inicio: { x: 50, y: 80 }, ponto_fim: { x: 250, y: 80 } },
      { ordem: 2, svg: 'M50,130 L250,130', ponto_inicio: { x: 50, y: 130 }, ponto_fim: { x: 250, y: 130 } }
    ]
  },
  {
    leitura: 'san',
    traducao: 'três',
    leitura_kun: 'みっ',
    leitura_on: 'サン',
    tracos: [
      { ordem: 1, svg: 'M50,70 L250,70', ponto_inicio: { x: 50, y: 70 }, ponto_fim: { x: 250, y: 70 } },
      { ordem: 2, svg: 'M70,120 L230,120', ponto_inicio: { x: 70, y: 120 }, ponto_fim: { x: 230, y: 120 } },
      { ordem: 3, svg: 'M50,170 L250,170', ponto_inicio: { x: 50, y: 170 }, ponto_fim: { x: 250, y: 170 } }
    ]
  },
  {
    leitura: 'juu',
    traducao: 'dez',
    leitura_kun: 'とお',
    leitura_on: 'ジュウ',
    tracos: [
      { ordem: 1, svg: 'M150,50 L150,200', ponto_inicio: { x: 150, y: 50 }, ponto_fim: { x: 150, y: 200 } },
      { ordem: 2, svg: 'M100,120 L200,120', ponto_inicio: { x: 100, y: 120 }, ponto_fim: { x: 200, y: 120 } }
    ]
  },
  {
    leitura: 'kuchi',
    traducao: 'boca',
    leitura_kun: 'くち',
    leitura_on: 'コウ',
    tracos: [
      { ordem: 1, svg: 'M100,100 L200,100', ponto_inicio: { x: 100, y: 100 }, ponto_fim: { x: 200, y: 100 } },
      { ordem: 2, svg: 'M200,100 L200,200', ponto_inicio: { x: 200, y: 100 }, ponto_fim: { x: 200, y: 200 } },
      { ordem: 3, svg: 'M200,200 L100,200', ponto_inicio: { x: 200, y: 200 }, ponto_fim: { x: 100, y: 200 } },
      { ordem: 4, svg: 'M100,200 L100,100', ponto_inicio: { x: 100, y: 200 }, ponto_fim: { x: 100, y: 100 } }
    ]
  },
  {
    leitura: 'nichi',
    traducao: 'sol',
    leitura_kun: 'ひ',
    leitura_on: 'ニチ',
    tracos: [
      { ordem: 1, svg: 'M100,80 L200,80', ponto_inicio: { x: 100, y: 80 }, ponto_fim: { x: 200, y: 80 } },
      { ordem: 2, svg: 'M200,80 L200,180', ponto_inicio: { x: 200, y: 80 }, ponto_fim: { x: 200, y: 180 } },
      { ordem: 3, svg: 'M200,180 L100,180', ponto_inicio: { x: 200, y: 180 }, ponto_fim: { x: 100, y: 180 } },
      { ordem: 4, svg: 'M100,180 L100,80', ponto_inicio: { x: 100, y: 180 }, ponto_fim: { x: 100, y: 80 } },
      { ordem: 5, svg: 'M100,130 L200,130', ponto_inicio: { x: 100, y: 130 }, ponto_fim: { x: 200, y: 130 } }
    ]
  },
  {
    leitura: 'ki',
    traducao: 'árvore',
    leitura_kun: 'き',
    leitura_on: 'モク',
    tracos: [
      { ordem: 1, svg: 'M150,50 L150,250', ponto_inicio: { x: 150, y: 50 }, ponto_fim: { x: 150, y: 250 } },
      { ordem: 2, svg: 'M100,150 L200,150', ponto_inicio: { x: 100, y: 150 }, ponto_fim: { x: 200, y: 150 } },
      { ordem: 3, svg: 'M120,100 L180,200', ponto_inicio: { x: 120, y: 100 }, ponto_fim: { x: 180, y: 200 } },
      { ordem: 4, svg: 'M180,100 L120,200', ponto_inicio: { x: 180, y: 100 }, ponto_fim: { x: 120, y: 200 } }
    ]
  },
  {
    leitura: 'naka',
    traducao: 'centro',
    leitura_kun: 'なか',
    leitura_on: 'チュウ',
    tracos: [
      { ordem: 1, svg: 'M100,100 L200,100', ponto_inicio: { x: 100, y: 100 }, ponto_fim: { x: 200, y: 100 } },
      { ordem: 2, svg: 'M150,100 L150,200', ponto_inicio: { x: 150, y: 100 }, ponto_fim: { x: 150, y: 200 } },
      { ordem: 3, svg: 'M100,200 L200,200', ponto_inicio: { x: 100, y: 200 }, ponto_fim: { x: 200, y: 200 } }
    ]
  },
  {
    leitura: 'yama',
    traducao: 'montanha',
    leitura_kun: 'やま',
    leitura_on: 'サン',
    tracos: [
      { ordem: 1, svg: 'M100,100 L100,200', ponto_inicio: { x: 100, y: 100 }, ponto_fim: { x: 100, y: 200 } },
      { ordem: 2, svg: 'M150,100 L150,250', ponto_inicio: { x: 150, y: 100 }, ponto_fim: { x: 150, y: 250 } },
      { ordem: 3, svg: 'M200,100 L200,200', ponto_inicio: { x: 200, y: 100 }, ponto_fim: { x: 200, y: 200 } }
    ]
  },
  {
    leitura: 'kawa',
    traducao: 'rio',
    leitura_kun: 'かわ',
    leitura_on: 'セン',
    tracos: [
      { ordem: 1, svg: 'M120,100 L120,200', ponto_inicio: { x: 120, y: 100 }, ponto_fim: { x: 120, y: 200 } },
      { ordem: 2, svg: 'M150,100 L150,200', ponto_inicio: { x: 150, y: 100 }, ponto_fim: { x: 150, y: 200 } },
      { ordem: 3, svg: 'M180,100 L180,200', ponto_inicio: { x: 180, y: 100 }, ponto_fim: { x: 180, y: 200 } }
    ]
  }
];

async function main() {
  try {
    await mongoose.connect(process.env.MONGODB_URI);
    await Kanji.insertMany(kanjis);
    console.log('Kanjis inseridos com sucesso!');
    mongoose.connection.close();
  } catch (error) {
    console.error('Erro ao inserir kanjis:', error.message);
    mongoose.connection.close();
  }
}

main();