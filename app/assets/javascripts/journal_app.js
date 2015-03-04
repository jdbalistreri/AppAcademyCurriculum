window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    // alert('Hello from Backbone!');
  }
};

$(document).ready(function(){
  JournalApp.initialize();
  var router = new JournalApp.Routers.PostsRouter({el: $(".router")});
  Backbone.history.start();
});
