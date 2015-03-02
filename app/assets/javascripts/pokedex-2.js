Pokedex.RootView.prototype.addToyToList = function (toy) {
  $toy = $("<li>").addClass("toy-item").data("toy-id", toy.id)
  $toy.append("Name: " + toy.escape("name") + "\n")
  $toy.append("Happiness: " + toy.escape("happiness") + "\n")
  $toy.append("Price: " + toy.escape("price") + "\n")

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

  this.$toyDetail.html($detail);
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  var toys = (this.pokes.get($(event.delegateTarget.children[0]).data('pokemon-id'))).toys();
  var toy = toys.get($(event.currentTarget).data('toy-id'));

  this.renderToyDetail(toy);
};
