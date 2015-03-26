TrelloClone.Views.ListForm = Backbone.CompositeView.extend({

  tagName: "li",
  className: "add-list-form",

  template: JST["list_form"],

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
    var attrs = $(event.target).serializeJSON().list;
    attrs.board_id = this.model.board.id;
    attrs.ord = this.collection.length;

    this.model.save(attrs, {
      success: function (newList) {
        that.collection.add(newList, {merge: true});
        that.toggleDisplay();

      },
    })
  },

})
