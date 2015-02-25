(function(){

  if(typeof Snake === "undefined"){
    window.Snake = {};
  }

  Snake.Snake = function(){
    this.prevDir = "W";
    this.nextDir = "W";
    this.segments = Snake.buildSnake();
  };

  Snake.buildSnake = function() {
    var segments = [];

    for (var i = 2; i < 5; i++) {
      segments.push(new Coord([3, i]));
    }

    return segments;
  }

  Snake.Snake.prototype.move = function () {
    this.segments.pop();
    this.segments.unshift(this.segments[0].nextCoord(this.nextDir));
    this.prevDir = this.nextDir;
  }

  Snake.Snake.prototype.turn = function(dir) {
    if (addArrays(DIRS[this.prevDir], DIRS[dir]).posEquals([0,0])){
      return;
    }
    this.nextDir = dir;
  }

  var DIRS = {"N": [-1, 0], "E": [0, 1], "W": [0, -1], "S": [1, 0]}

  Coord = function(pos){
    this.pos = pos;
  }

  Coord.prototype.nextCoord = function(dir){
    var newPos = addArrays(this.pos,DIRS[dir]);
    return new Coord(newPos);
  }

  Array.prototype.posEquals = function(otherPos){
    return this[0] === otherPos[0] && this[1] === otherPos[1];
  }

  var addArrays = function(arr1, arr2) {
    return [arr1[0] + arr2[0], arr1[1] + arr2[1]]
  }


  Snake.Board = function(){
    this.snake = new Snake.Snake();
  };

  Snake.Board.prototype.render = function(){
    var strArray = new Array(10);

    for (var i = 0; i < strArray.length; i++) {
      strArray[i] = [];
      for (var j = 0; j < strArray.length; j++) {
        strArray[i].push(".");
      }
    }

    this.snake.segments.forEach( function(coord) {
      var pos = coord.pos;
      strArray[pos[0]][pos[1]] = "S";
    })

    return strArray.map(function (el) {
      return el.join(" ")
    }).join("\n");
  };

})();
