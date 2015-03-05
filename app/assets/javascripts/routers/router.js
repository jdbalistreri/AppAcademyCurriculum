NewsReader.Routers.Router = Backbone.Router.extend({

  initialize: function (options) {
    this.$rootEl = options.$rootEl;

    this.collection = new NewsReader.Collections.Feeds();
    this.collection.fetch();
  },

  routes: {
    "": "index",
    "feeds/:id": "feedShow"
  },

  index: function () {
    var view = new NewsReader.Views.FeedsIndex( { collection: this.collection } );
    this._swapView(view);
  },

  feedShow: function (id) {
    var view = new NewsReader.Views.FeedShow( { model: this.collection.getOrFetch(id) } );
    this._swapView(view);
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }

})
