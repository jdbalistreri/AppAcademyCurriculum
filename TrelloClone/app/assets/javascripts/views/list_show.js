TrelloClone.Views.ListShow = Backbone.CompositeView.extend({

  tagName: "li",
  className: "list",

  template: JST["list_show"],

  events: {
    "click a.list-title" : "toggleDisplay",
    "click a.edit-list" : "editList",
    "click a.delete-list" : "deleteList",
    "submit form.new-list" : "handleSubmit",
    "sortstop .cards" : "handleSort"
  },

  initialize: function () {
    this.listenTo(this.model.cards(), "add remove", this.render);
    this.$el.data("id", this.model.id);
  },

  render: function () {
    var content = this.template( {list: this.model} );
    this.$el.html(content);

    this.makeSortable();

    this.addCardViews();
    return this;
  },

  makeSortable: function () {
    this.$(".cards").sortable({
      items: ".card",
      placeholder: "sortable-placeholder-card",
      connectWith: ".cards",

      start: function (event, ui) {
        debugger
        ui.item.addClass("dragged");
      },

      stop: function (event, ui) {
        ui.item.removeClass("dragged");
      },
    });
  },

  toggleDisplay: function() {
    this.$el.toggleClass("toggled");
  },


  editList: function () {
    this.$("header").toggleClass("toggled");
    this.toggleDisplay();
  },

  handleSort: function(event) {
    var view = this;
    var subviews = this.subviews(".cards");

    subviews.forEach( function (cardView) {
      if (cardView.$el.hasClass("card")) {
        var index = view.$(".card").index(cardView.$el)
        cardView.model.set("ord", index);
        cardView.model.save();
      }
    })
  },

  handleSubmit: function (event) {
    event.preventDefault();

    var that = this;
    var input = $(event.currentTarget).find("input");
    var attrs = $(event.currentTarget).serializeJSON().list

    this.model.save(attrs, {
      success: function () {
        that.$("header").toggleClass("toggled");
        input.val("");
      }
    });

  },

  deleteList: function () {
    this.model.destroy();
  },

  addCardViews: function () {

    var that = this;

    if (this.model.cards().models.length !== 0) {
      this.model.cards().models.forEach( function (card) {
        var cardView = new TrelloClone.Views.CardListItem({ model: card });
        that.addSubview(".cards", cardView);
      });
    }
    var newCard = new TrelloClone.Models.Card({list: this.model});
    var cardForm = new TrelloClone.Views.CardForm({
      model: newCard,
      collection: this.model.cards(),
    });

    this.addSubview(".cards", cardForm);
  },

});
