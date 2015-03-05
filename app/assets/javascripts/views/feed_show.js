NewsReader.Views.FeedShow = Backbone.View.extend({

  initialize: function () {
    // debugger
    this.model.fetch();
    this.listenTo(this.model, "sync", this.render);
  },

  template: JST["feed_show"],

  render: function () {
    var view = this.template( { feed: this.model } );
    this.$el.html(view);
    return this;
  }

})
