TrelloClone.Views.BoardForm = Backbone.CompositeView.extend({

  tagName: "li",

  template: JST["board_form"],

  events: {
    "submit form" : "handleSubmit",
    "click a.trigger" : "toggleDisplay",
  },

  initialize: function (options) {
    this.editView = options.editView;
  },

  render: function() {
    var content = this.template({board: this.model})
    this.$el.html(content);
    return this;
  },

  toggleDisplay: function() {
    this.$el.toggleClass("toggled");
  },

  handleSubmit: function (event) {
    event.preventDefault();
    this.$el.find(".errors").empty();

    var that = this;
    var attrs = $(event.target).serializeJSON().board

    this.model.save(attrs, {
      success: function (newBoard) {
        that.collection.add(newBoard);
        that.toggleDisplay();

      },
      error: function (newBoard, response) {
        that.$el.find(".errors").html(response.responseText);
      }
    })
  },

})
