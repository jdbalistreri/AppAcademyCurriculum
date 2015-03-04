JournalApp.Views.PostShow = Backbone.View.extend({

  initialize: function (options) {
    this.model = options.model;
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model, "destroy", this.redirectDestroy);
  },

  events: {
    "dblclick .post-title": "editTitle",
    "dblclick .post-body": "editBody",
    "blur .edit-title": "updateTitle",
    "blur .edit-body": "updateBody"
  },

  template: JST['post_show'],

  render: function () {
    var content = this.template({post: this.model});
    this.$el.html(content);
    return this;
  },

  redirectDestroy: function () {
    Backbone.history.navigate("", {trigger: true});
  },

  editTitle: function () {
    this.$el.find(".post-title").addClass("hidden");
    this.$el.find(".edit-title").removeClass("hidden");
  },

  updateTitle: function (event) {
    var that = this;
    this.$el.find(".post-title").removeClass("hidden");
    this.$el.find(".edit-title").addClass("hidden");

    var newTitle = event.target.value;
    this.model.set("title", newTitle);

    this.model.save();
  },

  editBody: function () {
    this.$el.find(".post-body").addClass("hidden");
    this.$el.find(".edit-body").removeClass("hidden");
  },

  updateBody: function (event) {
    var that = this;
    this.$el.find(".post-body").removeClass("hidden");
    this.$el.find(".edit-body").addClass("hidden");

    var newBody = event.target.value;
    this.model.set("body", newBody);

    this.model.save();
  }

})
