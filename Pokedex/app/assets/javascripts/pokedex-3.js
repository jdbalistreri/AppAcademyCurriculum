Pokedex.RootView.prototype.reassignToy = function (event) {
  var oldPokeId = $(event.currentTarget).data("pokemon-id");
  var toyId = $(event.currentTarget).data("toy-id");
  var oldPoke = this.pokes.get(oldPokeId);

  var toy = oldPoke.toys().get(toyId);
  toy.set('pokemon_id', $(event.currentTarget).val());
  toy.save({}, {
    success: function(){
      oldPoke.toys().remove(toy);
      this.renderToysList(oldPoke.toys());
      this.$toyDetail.empty();
    }.bind(this)
  })

};

Pokedex.RootView.prototype.renderToysList = function (toys) {
  this.$pokeDetail.find(".toys").empty();
  toys.forEach (function (toy) {
    this.addToyToList(toy);
  }.bind(this))
}

Pokedex.RootView.prototype.updatePoke = function (event){
  event.preventDefault();
  var attrs = $(event.currentTarget).serializeJSON();
  var updatedPoke = this.pokes.get(attrs["pokemon"]["id"]);
  updatedPoke.save(attrs["pokemon"], {
    success: function(){ alert('success!')}
  })

}
