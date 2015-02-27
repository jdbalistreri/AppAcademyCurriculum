// alert("it worked");

(function (){
  $.FollowToggle = function (el) {
    this.$el = $(el);
    this.userId = this.$el.data("user-id");
    this.followState = this.$el.data("initial-follow-state");
    this.request = null;
    this.render();
    this.handleClick();
  };


  $.FollowToggle.prototype.render = function () {
    if (this.followState === "followed") {
      this.$el.text("Unfollow!");
      this.request = $.FollowToggle.unfollowRequest;
    } else if (this.followState === "unfollowed") {
      this.$el.text("Follow!");
      this.request = $.FollowToggle.followRequest;
    }
  };

  $.FollowToggle.prototype.handleClick = function (){
    var that = this;

    this.$el.on("click", function (event) {
      event.preventDefault();
      that.request();
    })
  }

  $.FollowToggle.followRequest = function () {
    var that = this;
    return $.ajax({
      url: "/users/" + this.userId + "/follow",
      type: "post",
      dataType: "json",
      data: this.$el.serialize(),
      success: function(){
        that.followState = "followed";
        that.render();
        },
      failure: function(){alert("FAILURE");}
    })
  }

  $.FollowToggle.unfollowRequest = function () {
    var that = this;
    return $.ajax({
      url: "/users/" + this.userId + "/follow",
      type: "delete",
      data: this.$el.serialize(),
      dataType: "json",
      success: function () {
        that.followState = "unfollowed";
        that.render();},
      failure: function(){alert("FAILURE :(");}
    })
  }


  $.fn.followToggle = function () {
    return this.each(function () {
      new $.FollowToggle(this);
    });
  };


})();
