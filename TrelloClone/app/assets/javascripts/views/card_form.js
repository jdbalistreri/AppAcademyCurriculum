TrelloClone.Views.CardForm = Backbone.CompositeView.extend({

  tagName: "li",

  template: JST["card_form"],

  events: {
    "click a.trigger" : "toggleDisplay",
    "submit form" : "handleSubmit",
  },

  toggleDisplay: function() {
    this.$el.toggleClass("toggled")
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  handleSubmit: function (event) {
    event.preventDefault();

    var that = this;
    var attrs = $(event.target).serializeJSON().card;
    attrs.list_id = this.model.list.id;
    attrs.ord = this.collection.length;

    this.model.save(attrs, {
      success: function (newCard) {
        that.collection.add(newCard, {merge: true});
        // that.toggleDisplay();

      },
    })
  },

})
