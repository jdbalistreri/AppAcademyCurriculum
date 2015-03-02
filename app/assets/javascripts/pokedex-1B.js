Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var $detail = $("<div>").addClass("detail");
  $detail.append($("<img>").attr("src", pokemon.get("image_url")));

  var $table = $("<table>");

  ["name", "poke_type", "attack", "defense", "moves"].forEach(function (attr) {
    var $tr = $('<tr>');
    $tr.append($('<td>').text(attr));
    $tr.append($('<td>').text(pokemon.get(attr)));
    $table.append($tr);
  })

  $detail.append($table);

  this.$pokeDetail.html($detail);
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var id = $(event.currentTarget).data('id');
  var poke = this.pokes.findWhere({id: id});
  this.renderPokemonDetail(poke);
};
