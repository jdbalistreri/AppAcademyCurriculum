TrelloClone.Models.List = Backbone.Model.extend({

  initialize: function (options) {
    this.board = options.board;
  },

  urlRoot: "api/lists",

  cards: function () {
    if (!this._cards) {
      this._cards = new TrelloClone.Collections.Cards();
    }

    return this._cards;
  },


  parse: function (response) {

    if (response.cards) {
      this.cards().add(response.cards, {list: this});
      delete response.cards
    }
    return response;
  },

})
