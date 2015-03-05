NewsReader.Models.Feed = Backbone.Model.extend({

  urlRoot: "/api/feeds",

  entries: function () {
    if(!this._entries){
      this._entries = new NewsReader.Collections.Entries( { feed: this } );
    }

    this._entries.fetch();
    return this._entries;
  }

  

})
