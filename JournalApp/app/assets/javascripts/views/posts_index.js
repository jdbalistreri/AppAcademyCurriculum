JournalApp.Views.PostsIndex = Backbone.View.extend({

  initialize: function (options) {
    this.collection = options.collection;
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
