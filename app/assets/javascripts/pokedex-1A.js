Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var $poke = $("<li>").text(pokemon.get("name") + ": " + pokemon.get("poke_type"));
  $poke.addClass("poke-list-item");
  this.$pokeList.append($poke);
};

Pokedex.RootView.prototype.refreshPokemon = function (callback) {
  var that = this;
  this.pokes.fetch({
    success: function () {
      that.pokes.each( function (poke) {
        that.addPokemonToList(poke);
      });
    }
  });


};
