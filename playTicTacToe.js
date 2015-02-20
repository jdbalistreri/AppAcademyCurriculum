var TicTacToe = require ("./ttt/index.js")



var readline = require("readline");

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var g = new TicTacToe.Game(reader);


var completionCallback = function(board){
  if (board.won){
    console.log(board.winner() + " WINS!");
  }else{
    console.log("Uh oh, it was a tie :(");
  }
  reader.close();
  return;

}
g.run("x", completionCallback);
