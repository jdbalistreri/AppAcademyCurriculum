TrelloClone.Collections.Boards = Backbone.Collection.extend({

  url: "api/boards",

  comparator: "created_at",

  model: TrelloClone.Models.Board,


  getOrFetch: function (id) {
    var model = this.get(id);

    if (!model) {
      model = new TrelloClone.Models.Board({id: id});
      this.add(model);
    };

    model.fetch();

    return model;
  }

})
