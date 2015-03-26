Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var that = this;
  pokes.create(attrs, {
    success: function (data) {
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
