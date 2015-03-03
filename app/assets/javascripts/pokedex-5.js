Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click li" : "selectPokemonFromList"
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();
  },

  addPokemonToList: function (pokemon) {
    var content = JST["pokemonListItem"]({pokemon: pokemon});
    this.$el.append(content);
  },

  refreshPokemon: function (options) {
    this.collection.fetch ({
      success: this.render.bind(this)
    });
  },

  render: function () {
    var that = this;

    this.$el.empty();

    this.collection.each( function (pokemon) {
      that.addPokemonToList(pokemon);
    });

    return this;
  },

  selectPokemonFromList: function (event) {
    var poke = this.collection.get($(event.target).data("id"))
    var pokeView = new Pokedex.Views.PokemonDetail({ model: poke })
    $("#pokedex .pokemon-detail").html(pokeView.$el)
    pokeView.refreshPokemon();
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click .toys li" : "selectToyFromList"
  },

  refreshPokemon: function (options) {
    this.model.fetch({
      success: this.render.bind(this)
    });
  },

  render: function () {
    var content = JST["pokemonDetail"]({pokemon: this.model});
    this.$el.html(content);

    var $toys = this.$('.toys')

    this.model.toys().each((function(toy) {
      var toy = JST['toyListItem']({toy: toy});
      $toys.append(toy);
    }).bind(this));
  },

  selectToyFromList: function (event) {
    var toy = this.model.toys().get($(event.currentTarget).data("id"))
    var toyDetailView = new Pokedex.Views.ToyDetail({model: toy})
    $("#pokedex .toy-detail").html(toyDetailView.$el)
    toyDetailView.render();
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    var content = JST["toyDetail"]({toy: this.model, pokes: [] });
    this.$el.html(content);
  }
});

$(function () {
  var pokemonIndex = new Pokedex.Views.PokemonIndex();
  pokemonIndex.refreshPokemon();
  $("#pokedex .pokemon-list").html(pokemonIndex.$el);
});
