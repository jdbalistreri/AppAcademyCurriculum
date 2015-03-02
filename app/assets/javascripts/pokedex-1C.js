Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var that = this;
  var poke = new Pokedex.Models.Pokemon(attrs);
  poke.save({}, {
    success: function (data) {
      that.pokes.add(data);
      that.addPokemonToList(data);
      callback(data);
    },
    error: function () { console.log("error") }
  })
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();
  this.createPokemon($(event.currentTarget).serializeJSON(), this.renderPokemonDetail.bind(this));
};
