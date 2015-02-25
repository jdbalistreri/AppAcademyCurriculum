(function(){

  if(typeof Snake === "undefined"){
    window.Snake = {};
  }

  Snake.Snake = function(){
    this.dir = "W";
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
    this.segments.unshift(this.segments[0].nextCoord(this.dir));
  }

  Snake.Snake.prototype.turn = function(dir) {
    this.dir = dir;
  }

  var DIRS = {"N": [-1, 0], "E": [0, 1], "W": [0, -1], "S": [1, 0]}

  Coord = function(pos){
    this.pos = pos;
  }

  Coord.prototype.nextCoord = function(dir){
    var newPos = addArrays(this.pos,DIRS[dir]);
    return new Coord(newPos);
  }

  var addArrays = function(arr1, arr2) {
    return [arr1[0] + arr2[0], arr1[1] + arr2[1]]
  }

})();
