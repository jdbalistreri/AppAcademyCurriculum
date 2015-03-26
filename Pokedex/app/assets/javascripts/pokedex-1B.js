Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var that = this;
  var $detail = $("<div>").addClass("detail").data('pokemon-id', pokemon.id);
  $detail.append($("<img>").attr("src", pokemon.get("image_url")));

  // var $table = $("<table>");
  //
  // ["name", "poke_type", "attack", "defense", "moves"].forEach(function (attr) {
  //   var $tr = $('<tr>');
  //   $tr.append($('<td>').text(attr));
  //   $tr.append($('<td>').text(pokemon.get(attr)));
  //   $table.append($tr);
  // })
  //
  // $detail.append($table);

// ATTEMPT 2
  // $detail.append("<br>")
  // var $form = $("<form>").addClass('poke-update');
  //
  // ["name", "poke_type", "attack", "defense", "moves"].forEach(function (attr) {
  //   var $input = $('<input>');
  //   var $label = $('<label>').text(attr);
  //   $input.attr({
  //     type: "text",
  //     name: "pokemon[" + attr + "]",
  //     value: pokemon.escape(attr)
  //   });
  //   $form.append($label.append($input)).append("<br>");
  // })
  //
  // var $hidden = $('<input>').attr({
  //   type: 'hidden',
  //   name: 'pokemon[id]',
  //   value: pokemon.escape('id')
  // })
  //
  // $form.append($hidden);
  // $form.append($('<button>').text('Update'));

  var $form = (this.$el.find("script").html());



  $detail.append($form);


  $detail.append($('<ul>').addClass('toys'));

  pokemon.fetch({
    success: function (data) {
      this.renderToysList(data.toys())
    }.bind(this)
  });

  this.$pokeDetail.html($detail);
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var id = $(event.currentTarget).data('id');
  var poke = this.pokes.get(id);
  this.renderPokemonDetail(poke);
};
