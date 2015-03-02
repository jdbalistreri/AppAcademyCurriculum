Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var that = this;
  var $detail = $("<div>").addClass("detail").data('pokemon-id', pokemon.id);
  $detail.append($("<img>").attr("src", pokemon.get("image_url")));

  var $table = $("<table>");

  ["name", "poke_type", "attack", "defense", "moves"].forEach(function (attr) {
    var $tr = $('<tr>');
    $tr.append($('<td>').text(attr));
    $tr.append($('<td>').text(pokemon.get(attr)));
    $table.append($tr);
  })

  $detail.append($table);
  $detail.append($('<ul>').addClass('toys'));

  pokemon.fetch({
    success: function (data) {
      data.toys().forEach( function (toy) {
        that.addToyToList(toy);
      })
    }
  });

  this.$pokeDetail.html($detail);
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var id = $(event.currentTarget).data('id');
  var poke = this.pokes.get(id);
  this.renderPokemonDetail(poke);
};
