JournalApp.Views.PostForm = Backbone.View.extend({

  events: {
    "submit" : "handleSubmit"
  },

  template: JST["post_form"],

  initialize: function (options) {
    this.model = options.model;
    this.collection = options.collection;
  },

  render: function () {
    var content = this.template({})
    this.$el.html(content);
    return this;
  },

  handleSubmit: function (event) {
    event.preventDefault();
    var that = this;
    var attrs = $(event.target).serializeJSON().post;
    this.model.save(attrs,{
      success: function (data) {
        that.collection.add(that.model, {merge: true});
        Backbone.history.navigate("", {trigger: true});
      },
      error: function (model, response) {
        alert(response.responseText);
      }
    });
  }

})
