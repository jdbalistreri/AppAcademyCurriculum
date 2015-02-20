var readline = require("readline");

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function HanoiGame() {
  this.stacks = [[3,2,1], [], []]
};


HanoiGame.prototype.isWon = function() {
  var stacks = this.stacks;
  return (stacks[0].length === 0) &&
    (stacks[1].length === 0 || stacks[2].length === 0);
};


HanoiGame.prototype.isValidMove = function (startIdx, endIdx) {
  var start = this.stacks[startIdx];
  var finish = this.stacks[endIdx];
  return start.length !== 0 &&
    (finish.length === 0 ||
      (finish.slice(-1)[0] > start.slice(-1)[0]));
};

HanoiGame.prototype.move = function(startIdx, endIdx){
  if (this.isValidMove(startIdx, endIdx)) {
    this.stacks[endIdx].push(this.stacks[startIdx].pop());
  } else {
    console.log("Invalid move");
  }
};

HanoiGame.prototype.print = function () {
  console.log("Stacks: " + JSON.stringify(this.stacks));
};

HanoiGame.prototype.promptMove = function (callback) {
  this.print();

  reader.question("Start tower idx: ", function (start) {
    reader.question("End tower idx: ", function (stop) {
      callback(start, stop);
    });
  });
};

HanoiGame.prototype.run = function (completionCallback) {
  var game = this;

  game.promptMove(function(start, stop) {

    game.move.call(game,start,stop);
    if ( game.isWon.call(game) ) {
      completionCallback();
    } else {
      game.run.call(game,completionCallback);
    }
  });
};


var h = new HanoiGame();
var completion = function () {
  h.print();
  console.log("You have won the game!");
  reader.close();
  return;
};


h.run( completion );
