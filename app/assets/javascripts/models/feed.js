NewsReader.Models.Feed = Backbone.Model.extend({

  urlRoot: "/api/feeds",

  entries: function () {

    if(!this._entries){
      this._entries = new NewsReader.Collections.Entries( [], { feed: this } );
    }

    return this._entries;
  },

  parse: function (feed) {

    if(feed.latest_entries){
      this.entries();
      this._entries.set(feed.latest_entries);
      delete feed.latest_entries;
    }

    return feed;
  }

})
