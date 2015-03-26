TrelloClone.Views.CardListItem = Backbone.CompositeView.extend({

  tagName: "li",
  className: "card",

  template: JST["card_list_item"],

  events: {
    "click a.card-title" : "toggleModal",
  },

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
    this.$el.data("id", this.model.id);
  },

  render: function () {
    var content = this.template( {card: this.model} );
    this.$el.html(content);
    return this;
  },

  toggleModal: function (event) {
    var $modal = $(".modal1");
    $modal.toggleClass("toggled");
    var cardShowView = new TrelloClone.Views.CardShow({model: this.model})
    // $modal.find(".card-show").html(cardShowView.render().$el);
    this.addSubview(".card-show", cardShowView)
  },

});
