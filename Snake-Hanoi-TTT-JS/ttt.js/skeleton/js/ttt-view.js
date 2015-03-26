(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el, $text) {
    this.grid = $el;
    this.game = game;
    this.result = $text;
  };

  View.prototype.bindEvents = function () {
    var view = this;
    view.grid.on("click", "li", function(event){
      $li = $(event.currentTarget);

      $li.addClass("clicked");

      view.makeMove($li);
    });
  };

  View.prototype.makeMove = function ($square) {
    var pos = $square.data("id");
    if( this.game.board.isEmptyPos(pos) ){
      $square.text(this.game.currentPlayer);
      $square.addClass(this.game.currentPlayer);

      this.game.playMove(pos);
    } else {
      alert("Invalid Move!");
    }

    if (this.game.isOver()) {
      if (this.game.winner()) {
        this.result.text("Winner is " + this.game.winner().toUpperCase())
        var $winnerCells = $(".grid > ." + this.game.winner());

        $winnerCells.addClass("winner");
      } else {
        this.result.text("Draw")
      }
      this.grid.off("click");
      $(".grid > li:not(.clicked)").addClass("clicked");

    }
  };

  View.prototype.setupBoard = function () {
    for(var i = 0; i < 3; i++){
      for(var j = 0; j < 3; j++){
        var $cell = $(document.createElement("li"));

        $cell.data("id", [i, j] );

        this.grid.append( $cell );
      }
    }

  };
})();
