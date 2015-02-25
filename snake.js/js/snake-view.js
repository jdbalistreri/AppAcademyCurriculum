(function () {

  if(window.Snake === undefined) {
    window.Snake = {}
  }

  Snake.View = function($el) {
    this.$el = $el;
    this.board = new Snake.Board();
  }


  Snake.View.prototype.bindEvents = function() {
    var view = this;
    $(window).on("keydown", function(event){
      view.handleKeyEvent(event);
    });
  }

  Snake.View.prototype.handleKeyEvent = function(event){
    if(event.keyCode === 37){ //left
      this.board.snake.turn("W");
    }else if(event.keyCode === 38){//up
      this.board.snake.turn("N");
    }else if(event.keyCode === 39){//right
      this.board.snake.turn("E");
    }else if(event.keyCode === 40){//down
      this.board.snake.turn("S");
    }
  }

  Snake.View.prototype.step = function() {
    this.board.snake.move();
    this.$el.text(this.board.render());
  };


})();
