JournalApp.Views.PostShow = Backbone.View.extend({

  initialize: function (options) {
    this.model = options.model;
    this.listenTo(this.model, "sync", this.render)
    this.listenTo(this.model, "destroy", this.redirectDestroy)
  },

  template: JST['post_show'],

  render: function () {
    var content = this.template({post: this.model});
    this.$el.html(content);
    return this;
  },

  redirectDestroy: function () {
    Backbone.history.navigate("", {trigger: true});
  }

})
