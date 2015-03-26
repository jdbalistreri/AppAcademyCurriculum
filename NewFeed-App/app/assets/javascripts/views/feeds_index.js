NewsReader.Views.FeedsIndex = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.collection, "sync", this.render);
  },

  template: JST["feeds_index"],

  render: function () {
    var view = this.template( { feeds: this.collection } );
    this.$el.html(view);
    return this;
  }

})
