Pokedex.RootView.prototype.reassignToy = function (event) {
  var oldPokeId = $(event.currentTarget).data("pokemon-id");
  var toyId = $(event.currentTarget).data("toy-id");
  var oldPoke = this.pokes.get(oldPokeId);

  var toy = oldPoke.toys().get(toyId);
  toy.set('pokemon_id', $(event.currentTarget).val());
  toy.save({}, {
    success: function(){
      oldPoke.toys().remove(toy);
      this.renderPokemonDetail(oldPoke);
      this.$toyDetail.empty();
    }.bind(this)
  })

};
