(function (){
  $.UsersSearch = function (el) {
    this.$el = $(el);
    this.$input = this.$el.find("input");
    this.$ul = this.$el.find(".users");
    this.$input.on("input", this.handleInput.bind(this))
  };

  $.UsersSearch.prototype.handleInput = function (event) {
    var searchValue = event.currentTarget.value;

    $.ajax({
      url: "/users/search",
      type: "get",
      data: {query: searchValue},
      dataType: "json",
      success: this.handleResults.bind(this),
      failure: function () {
        alert("this failed")
      },
    })
  }

  $.UsersSearch.prototype.handleResults = function (users) {
    var that = this;
    that.$ul.empty();
    users.forEach( function (user) {
      var $li = $("<li>").text(user.username);
      var $button = $("<button>").addClass("follow-toggle");

      $button.followToggle({userId: user.id, followState: user.followed});

      $li.append($button);
      that.$ul.append($li);
    })
  }

  $.fn.usersSearch = function () {
    return this.each(function () {
      new $.UsersSearch(this);
    });
  };



})();
