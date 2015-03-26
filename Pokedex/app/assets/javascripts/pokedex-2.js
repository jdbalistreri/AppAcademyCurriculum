Pokedex.RootView.prototype.addToyToList = function (toy) {
  var $toy = $("<li>").addClass("toy-item").data("toy-id", toy.id);
  $toy.append("Name: " + toy.escape("name") + "\n");
  $toy.append("Happiness: " + toy.escape("happiness") + "\n");
  $toy.append("Price: " + toy.escape("price") + "\n");

  this.$pokeDetail.find(".detail > ul.toys").append($toy)
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  var $detail = $("<div>").addClass("detail");

  $detail.append($("<img>").attr("src", toy.get("image_url")));

  var $table = $("<table>");

  ["name", "price", "happiness"].forEach(function (attr) {
    var $tr = $('<tr>');
    $tr.append($('<td>').text(attr));
    $tr.append($('<td>').text(toy.get(attr)));
    $table.append($tr);
  })

  $detail.append($table);

  var $select = $('<select>').data('pokemon-id', toy.get('pokemon_id')).data('toy-id', toy.get('id'))
  this.pokes.forEach(function(poke){
    var $opt = $('<option>').attr({name: 'toy[pokemon_id]', value: poke.id}).text(poke.get('name'));
    if (toy.get('pokemon_id') === poke.get("id")) {
      $opt.attr("selected", "selected");
    }
    $select.append($opt);
  })


  $detail.append($select);

  this.$toyDetail.html($detail);
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {

  var poke = (this.pokes.get($(event.delegateTarget.children[0]).data('pokemon-id')));
  var toy = poke.toys().get($(event.currentTarget).data('toy-id'));

  this.renderToyDetail(toy);
};
