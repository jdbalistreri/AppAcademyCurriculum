NewsReader.Views.FeedShow = Backbone.View.extend({

  events: {
    "click button": "refresh"
  },

  refresh: function () {
    var that = this;
    this.model.fetch({
      success: function () {
        that.render();
      }
    });
  },

  initialize: function () {
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
