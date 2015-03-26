var Board = require("./board");

function Game(reader) {
  this.reader = reader;
  this.board = new Board();
};


Game.prototype.run = function (turn, completionCallback) {

  var board = this.board;
  board.print();
  var game = this;

  if (board.gameOver()) {
    completionCallback(this.board)
  } else {
    game.reader.question(turn + ": which row?  ", function(rowIdx){
      game.reader.question(turn + ": which col?  ", function(colIdx) {
        board.makeMove([parseInt(rowIdx), parseInt(colIdx)],turn);
        turn = turn === "x" ? "o" : "x";
        game.run(turn, completionCallback);
      });
    });

  }
};

module.exports = Game
