alert("it worked");

(function (){
  $.FollowToggle = function (el) {
    this.$el = $(el);
    this.userId = this.$el.data("user-id");
    this.followState = this.$el.data("initial-follow-state");
    this.render();
  };

  $.FollowToggle.prototype.render = function () {
    if (this.followState === "followed") {
      this.$el.text("Unfollow!");
    } else if (this.followState === "unfollowed") {
      this.$el.text("Follow!");
    }
  };

  $.fn.followToggle = function () {
    return this.each(function () {
      new $.FollowToggle(this);
    });
  };


})();
