// alert("it worked");

(function (){
  $.FollowToggle = function (el) {
    this.$el = $(el);
    this.userId = this.$el.data("user-id");
    this.followState = this.$el.data("initial-follow-state");
    this.render();
    this.handleClick();
  };


  $.FollowToggle.prototype.render = function () {
    if (this.followState === "followed") {
      this.$el.prop("disabled", false);
      this.$el.text("Unfollow!");
      this.request = $.FollowToggle.unfollowRequest;

    } else if (this.followState === "unfollowed") {
      this.$el.prop("disabled", false);
      this.$el.text("Follow!");
      this.request = $.FollowToggle.followRequest;

    } else if (this.followState === "following") {
      this.$el.text("Following...");
      this.$el.prop("disabled", true);

    } else if (this.followState === "unfollowing") {
      this.$el.text("Unfollowing...");
      this.$el.prop("disabled", true);
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
    this.followState = "following";
    this.render();

    return $.ajax({
      url: "/users/" + this.userId + "/follow",
      type: "post",
      dataType: "json",
      success: function(){
        that.followState = "followed";
        that.render();
        },
      failure: function(){
        that.followState = "unfollowed";
        that.render();
      }
    })
  }

  $.FollowToggle.unfollowRequest = function () {
    var that = this;
    this.followState = "unfollowing";
    this.render();

    return $.ajax({
      url: "/users/" + this.userId + "/follow",
      type: "delete",
      dataType: "json",
      success: function () {
        that.followState = "unfollowed";
        that.render();},
      failure: function(){
        that.followState = "followed";
        that.render();
      }
    })
  }


  $.fn.followToggle = function () {
    return this.each(function () {
      new $.FollowToggle(this);
    });
  };


})();
