JournalApp.Routers.PostsRouter = Backbone.Router.extend({

  initialize: function (options) {
    this.$el = $(options.el)
  },

  routes: {
    "" : "index",
    "posts/:id" : "show"
  },

  index: function (callback) {
    this._indexView = new JournalApp.Views.PostsIndex({success: callback});
    this.$el.html(this._indexView.$el);
  },

  show: function(id) {
    if (!this._indexView){
      this.index(this.show.bind(this, id));
      return;
    }

    var post = this._indexView.collection.getOrFetch(id);
    this._showView = new JournalApp.Views.PostShow({model: post});
    this.$el.html(this._showView.render().$el);
  }

})
