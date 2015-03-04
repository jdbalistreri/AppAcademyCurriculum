JournalApp.Routers.PostsRouter = Backbone.Router.extend({

  initialize: function (options) {
    this.$el = $(options.el)
    this.collection = new JournalApp.Collections.Posts();
    this.collection.fetch();
    this.index();
  },

  routes: {
    "" : "new",
    "posts/new" : "new",
    "posts/:id" : "show"
  },

  index: function () {
    this._indexView = new JournalApp.Views.PostsIndex({collection: this.collection});
    this.$el.find(".sidebar").html(this._indexView.render().$el);
  },

  new: function () {
    var newPost = new JournalApp.Models.Post();
    this._newView = new JournalApp.Views.PostForm({
      model: newPost,
      collection: this.collection
    });
    this._swapView(this._newView);
  },

  show: function(id) {
    var post = this.collection.getOrFetch(id);

    this._showView = new JournalApp.Views.PostShow({model: post});
    this._swapView(this._showView);
  },

  _swapView: function (newView) {
    if (this._currentView) {
      this._currentView.remove();
    }

    this.$el.find(".content").html(newView.render().$el);
    this._currentView = newView;
  }

})
