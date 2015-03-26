TrelloClone.Views.BoardShow = Backbone.CompositeView.extend({

  initialize: function () {
    this.model.fetch();
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.lists(), "add", this.handleListAdd);
    this.listenTo(this.model.lists(), "remove", this.handleListRemove);
  },

  template: JST["board_show"],

  events: {
    "click .modal-background" : "toggleModal",
    "click a.delete-board" : "handleDelete",
    "sortstop .lists" : "handleSort",
    "click .edit-board" : "toggleDisplay",
    "submit form.board-form" : "handleSubmit",
  },

  addListForm: function () {
    var newList = new TrelloClone.Models.List({board: this.model});
    var listForm = new TrelloClone.Views.ListForm({
      model: newList,
      collection: this.model.lists(),
    });

    this.addSubview(".lists", listForm);
  },

  addListViews: function () {
    var that = this;

    if (this.model.lists().models.length !== 0) {
      this.model.lists().models.forEach( function (list) {
        var listView = new TrelloClone.Views.ListShow({ model: list });
        that.addSubview(".lists", listView);
      });
    }

    this.addListForm();
  },

  handleDelete: function(event) {
    this.model.destroy();
    this.remove();
    Backbone.history.navigate("", {trigger: true});
  },

  handleListAdd: function(model) {
    var subviews = this.subviews(".lists")
    var formView = subviews[(subviews.length - 1)]
    this.removeSubview(".lists", formView)

    var listView = new TrelloClone.Views.ListShow({ model: model });
    this.addSubview(".lists", listView);

    this.addListForm();
    this.setContainerWidth();
  },

  handleListRemove: function(model) {
    var that = this;

    this.subviews(".lists").forEach(function (subview) {
      if (subview.model.cid === model.cid) {
        that.removeSubview(".lists", subview)
      }
    })

    this.setContainerWidth();
  },

  handleSort: function(event) {
    var view = this;

    this.$(".list").each( function (id) {
      var list = view.model.lists().get($(this).data("id"))
      list.set("ord", id + 1);
      list.save();
    });
  },

  handleSubmit: function (event) {
    event.preventDefault();

    var that = this;
    var input = $(event.currentTarget).find("input");
    var attrs = $(event.currentTarget).serializeJSON().board

    this.model.save(attrs, {
      success: function (model) {
        input.val("");
        that.toggleDisplay();
        that.$("h3.board-title").html(model.escape("title"))
      }
    });
  },

  render: function () {
    var content = this.template({board: this.model});
    this.$el.html(content);

    this.addListViews();
    this.setContainerWidth();

    this.$(".lists").sortable({
      items: ".list"
    });
    return this;
  },

  setContainerWidth: function () {
    var pixelWidth = 100 + this.$(".lists").children().length * 250;
    this.$(".lists").css("width", pixelWidth);
  },

  toggleDisplay: function() {
    this.$el.toggleClass("toggled");
  },


    toggleModal: function (event) {
      var $modal = $(".modal1");
      $modal.toggleClass("toggled");
      // $modal.find(".card-show").html(this.render().$el);
    },

})
