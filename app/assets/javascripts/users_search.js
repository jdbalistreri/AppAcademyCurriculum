(function (){
  $.UsersSearch = function (el) {
    this.$el = $(el);
    this.$input = $(this.$el.find("input"));
    this.$ul = $(this.$el.find(".users"));
    this.handleInput();
  };

  $.UsersSearch.prototype.handleInput = function () {
    var that = this;

    this.$input.on("input", function (event) {
      that.searchRequest(event.currentTarget.value);
    })
  }

  $.UsersSearch.prototype.searchRequest = function (searchValue) {
    var that = this;

    $.ajax({
      url: "/users/search",
      type: "get",
      data: {query: searchValue},
      dataType: "json",
      success: that.handleResults.bind(that),
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
