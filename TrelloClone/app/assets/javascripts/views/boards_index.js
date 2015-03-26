TrelloClone.Views.BoardsIndex = Backbone.CompositeView.extend({

  initialize: function () {
    this.listenTo(this.collection, "sync remove", this.render);
  },

  template: JST["boards_index"],

  render: function() {
    var content = this.template({boards: this.collection})
    this.$el.html(content);

    var model = new TrelloClone.Models.Board();
    var newView = new TrelloClone.Views.BoardForm({model: model, collection: this.collection});

    this.addSubview(".board-index", newView);

    return this;
  },


})
