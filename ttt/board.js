
function Board() {
  this.rows = [ [undefined ,undefined , undefined],
              [undefined ,undefined , undefined],
              [undefined ,undefined , undefined]]
}


Board.prototype.readPos = function (pos) {
  return this.rows[pos[0]][pos[1]];
};

Board.prototype.writePos = function (pos, value) {
  this.rows[pos[0]][pos[1]] = value;
};


Board.prototype.validMove = function (pos) {

  return (pos[0] >= 0 && pos[0] <= 2  && pos[1] >= 0 && pos[1] <= 2) &&
  typeof this.readPos(pos) === "undefined";
};


Board.prototype.makeMove = function (pos, mark) {
  if (this.validMove(pos)) {
    this.writePos(pos, mark);
  }
};

Board.prototype.boardFull = function () {
  var count = 0;

  this.rows.forEach(function (row) {
    row.forEach(function (el) {
      if(el !== undefined) {
        count++
      }
    });
  });

  return count === 9;
};

Board.prototype._rows = function() {
  return this.rows;
};

Board.prototype._cols = function() {
  var cols = [[],[],[]];
  var i, j;

  for (i = 0; i < 3; i++) {
    for(j = 0; j < 3; j++) {
      cols[j][i] = this.readPos([i,j])
    };
  };

  return cols;
};

Board.prototype._diags = function () {
  var diagPos = [[[0,0], [1,1], [2,2]],
               [[2,0], [1,1], [0,2]]];
  var diags = [[],[]];
  var i, j;
  var board = this;

  for (i = 0; i < diagPos.length; i++ ) {
    var diag = diagPos[i]

    for (j = 0; j < diag.length; j++) {
      diags[i].push(board.readPos(diag[j]));
    };
  };

  return diags;
};

Board.prototype.winner = function () {
  var combos = this._rows().concat(this._cols()).concat(this._diags());
  var i;
  var allEquals = function(array, val){
    var allEqual = true
    for(var k = 0; k < array.length; k++){
      allEqual = allEqual && array[k] === val;
    };
    return allEqual;
  };
  for (i = 0; i < combos.length; i++){
    if (allEquals(combos[i], "x")){
      return "x";
    }else if (allEquals(combos[i], "o")){
      return "o";
    }
  };
  return null;
};

Board.prototype.won = function () {
  return !!this.winner();
};

Board.prototype.tie = function () {
  return this.boardFull() && !this.won();
};

Board.prototype.print = function () {
  var cleanRows = this.rows.map(function (row) {
    console.log(row.map( function(el) {
      return el === undefined ? " " : el;
    }));
  });
}

Board.prototype.gameOver = function () {
  return this.won() || this.tie();
};



b = new Board();
b.makeMove([1,1], "x");
b.makeMove([0,1], "o");
b.makeMove([0,0], "o");


module.exports = Board;
