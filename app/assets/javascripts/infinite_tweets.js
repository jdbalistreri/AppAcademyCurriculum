(function () {

  $.InfiniteTweets = function (el) {
    this.$el = $(el);
    this.bindEvents();
    this.maxCreatedAt = null;
  };


  $.InfiniteTweets.prototype.bindEvents = function () {
    this.$el.on("click", "a.fetch-more", this.fetchTweets.bind(this))
  }


  $.InfiniteTweets.prototype.fetchTweets = function () {

    var data = {limit: 5}

    if (this.maxCreatedAt !== null) {
      data.max_created_at = this.maxCreatedAt;
    }

    $.ajax({
      url: "/feed",
      type: "get",
      dataType: "json",
      data: data,
      success: this.insertTweets.bind(this),
      error: function () {alert("error")}
    })
  }


  $.InfiniteTweets.prototype.insertTweets = function (response) {
    var $feed = this.$el.find("#feed");

    response.forEach(function (tweet) {
      $feed.append($("<li>").text(JSON.stringify(tweet)));
    })

    this.maxCreatedAt = response[response.length - 1].created_at;

    if ($feed.find("li").length >= 20 || response.length === 0) {
      this.$el.find("a.fetch-more").remove();
      $feed.prepend($("<strong>").text("no more tweets"));
    }
  }


  $.fn.infiniteTweets = function () {
    return this.each(function () {
      new $.InfiniteTweets(this);
    })
  }


})();
