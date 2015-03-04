JournalApp.Views.PostsIndex = Backbone.View.extend({

  initialize: function (options) {
    this.collection = new JournalApp.Collections.Posts();
    this.collection.fetch({
      success: function(){
        options.success && options.success();
      }
    });

    this.listenTo(this.collection, "remove sync", this.render);
  },

  template: JST['posts_index'],

  render: function(){
    var content = this.template({posts: this.collection});
    this.$el.html(content);
    var $ul = $('<ul>');
    this.collection.forEach( function(post){
      var postView = new JournalApp.Views.PostIndexItem({model: post});
      $ul.append(postView.render().$el);
    });

    this.$el.append($ul);
    return this;
  }
})


JournalApp.Views.PostIndexItem = Backbone.View.extend({

  events: {
    "click .delete-post": "handleDelete"
  },

  tagName: 'li',

  template: JST['post_index_item'],

  render: function () {
    var content = this.template({post: this.model});
    this.$el.html(content);
    return this;
  },

  handleDelete: function () {
    this.model.destroy();
  }

})

JournalApp.Views.PostShow = Backbone.View.extend({

  template: JST['post_show'],

  render: function () {
    var content = this.template({post: this.model});
    this.$el.html(content);
    return this;
  }

})
