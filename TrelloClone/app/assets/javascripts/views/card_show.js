TrelloClone.Views.CardShow = Backbone.CompositeView.extend({

  template: JST["card_show"],

  events: {
    "click a.edit-card" : "editCard",
    "click button.delete-card" : "deleteCard",
    "submit form" : "handleSubmit",
  },

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
    this.$el.data("id", this.model.id);
  },

  render: function () {
    var content = this.template( { card: this.model } );
    this.$el.html(content);
    return this;
  },

  toggleDisplay: function() {
    this.$el.toggleClass("toggled");
  },

  editCard: function () {
    // this.$("header").toggleClass("toggled");
    // this.toggleDisplay();
  },

  handleSubmit: function (event) {
    event.preventDefault();

    var that = this;
    var input = $(event.currentTarget).find("input");
    var attrs = $(event.currentTarget).serializeJSON().card

    this.model.save(attrs, {
      success: function () {
        that.$("header").toggleClass("toggled");
        input.val("");
      }
    });

  },

  deleteCard: function () {
    this.model.destroy();
  },

});
