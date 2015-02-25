(function(){

  if (typeof Hanoi === "undefined") {
    window.Hanoi = {};
  }

  var View = Hanoi.View = function(game, $towers, $text){
    this.game = game;
    this.$towers = $towers;
    this.gameText = $text;
    this.firstClicked = null;
  };


  View.prototype.bindEvents = function () {
    var view = this;

    this.$towers.on("click", ".tower", function(event){
      var $clickedTower = $(event.currentTarget);
      console.log($clickedTower.data("id"))

      if(view.firstClicked === null){
        view.firstClicked = $clickedTower;
        $clickedTower.addClass("clicked");
      } else {
        view.makeMove(view.firstClicked, $clickedTower);
        view.firstClicked.removeClass("clicked");
        view.firstClicked = null;
      }

    })
  };

  View.prototype.makeMove = function ($startTower, $endTower) {
    var startIdx = $startTower.data("id")
    var endIdx = $endTower.data("id")

    if (this.game.isValidMove(startIdx, endIdx)) {
      this.game.move(startIdx, endIdx)
      this.render();
    } else {
      alert("Invalid move!");
    }
  };

  View.prototype.render = function(){
    var view = this;
    this.$towers.find(".disc").removeClass("disc-size-1");
    this.$towers.find(".disc").removeClass("disc-size-2");
    this.$towers.find(".disc").removeClass("disc-size-3");

    view.game.towers.forEach( function(tower, index) {
      tower.forEach( function(disc, discIndex) {
        var $currentTower = $(view.$towers.find(".tower-" + index));
        var $disc = $currentTower.find(".disc:nth-last-child(" + (1 + discIndex) + ")");
        console.log($disc);
        $disc.addClass("disc-size-" + disc);
      });
    });

  };

  View.prototype.setupBoard = function () {
    var view = this

    view.game.towers.forEach( function(tower, index) {
      var $tower = $(document.createElement("ul"))
      $tower.addClass("tower tower-" + index)
      $tower.data("id", index)

      for(var i = 0; i < 3; i++){
        var $disc = $(document.createElement("li"))
        $disc.addClass("disc");
        $tower.append($disc);
      }

      view.$towers.append($tower);
    })

    view.render();
  };


})();
