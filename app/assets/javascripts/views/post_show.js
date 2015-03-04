JournalApp.Views.PostShow = Backbone.View.extend({

  initialize: function (options) {
    this.model = options.model;
    this.listenTo(this.model, "sync", this.render)
  },

  template: JST['post_show'],

  render: function () {
    var content = this.template({post: this.model});
    this.$el.html(content);
    return this;
  }

})
