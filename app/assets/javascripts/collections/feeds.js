NewsReader.Collections.Feeds = Backbone.Collection.extend({
  url: "/api/feeds",
  model: NewsReader.Models.Feed,

  getOrFetch: function (id) {
    var model = this.get(id);

    if (!model) {
      model = new NewsReader.Models.Feed({id: id})
      this.add(model);
    }

    model.fetch();
    return model;
  }
})
