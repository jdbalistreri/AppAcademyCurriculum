JournalApp.Views.PostIndexItem = Backbone.View.extend({

  events: {
    "click .delete-post": "handleDelete"
  },

  tagName: 'li',

  template: JST['post_index_item'],

  initialize: function() {
    this.listenTo(this.model, "change", this.render);
  },

  render: function () {
    var content = this.template({post: this.model});
    this.$el.html(content);
    return this;
  },

  handleDelete: function () {
    this.model.destroy();
  }

})
