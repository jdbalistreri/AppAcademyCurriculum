JournalApp.Collections.Posts = Backbone.Collection.extend({
  url: "/posts",
  model: JournalApp.Models.Post,

  getOrFetch: function(id) {
    var post = this.get(id);
    var that = this;
    if (!post) {
      post = new JournalApp.Models.Post({id: id});
    }
    this.add(post);
    post.fetch();
    return post;
  }

})
