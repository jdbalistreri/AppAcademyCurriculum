JournalApp.Routers.PostsRouter = Backbone.Router.extend({

  initialize: function (options) {
    this.$el = $(options.el)
    this.collection = new JournalApp.Collections.Posts();
    this.collection.fetch();
  },

  routes: {
    "" : "index",
    "posts/:id" : "show"
  },

  index: function () {
    this._indexView = new JournalApp.Views.PostsIndex({collection: this.collection});
    this.$el.html(this._indexView.render().$el);
  },

  show: function(id) {
    var post = this.collection.getOrFetch(id);

    this._showView = new JournalApp.Views.PostShow({model: post});
    this.$el.html(this._showView.render().$el);
  }

})
