TrelloClone.Routers.Router = Backbone.Router.extend({

  initialize: function(options) {
    this.$rootEl = options.$rootEl;
    this.collection = new TrelloClone.Collections.Boards();
    this.collection.fetch();
  },

  routes: {
    "" : "index",
    "boards/:id" : "show",
    "boards/:id/edit" : "edit",
  },

  edit: function (id) {
    var model = this.collection.getOrFetch(id);
    var view = new TrelloClone.Views.BoardForm({model: model, collection: this.collection, editView: true});
    this._swapView(view)
  },

  index: function () {
    var view = new TrelloClone.Views.BoardsIndex({collection: this.collection});

    $(this.$rootEl).addClass("index");
    this._swapView(view)
  },

  new: function () {
    var model = new TrelloClone.Models.Board();
    var view = new TrelloClone.Views.BoardForm({model: model, collection: this.collection});

    this._swapView(view)
  },

  show: function(id) {
    var model = this.collection.getOrFetch(id);
    var view = new TrelloClone.Views.BoardShow({model: model});

    $(this.$rootEl).removeClass("index")
    this._swapView(view)
  },


  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  },


})
