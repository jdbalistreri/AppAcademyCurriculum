(function (){
  $.TweetCompose = function (el) {
    this.$el = $(el);
    this.bindEvents();
  };

  $.TweetCompose.prototype.bindEvents = function () {
    this.$el.on("submit", this.handleSubmit.bind(this));
    this.$el.on("input", "textarea", this.charsLeft.bind(this));
    this.$el.on("click", "a.add-mentioned-user", this.addMentionedUser.bind(this));
    this.$el.on("click", "a.remove-mentioned-user", this.removeMentionedUser.bind(this));
  };

  $.TweetCompose.prototype.removeMentionedUser = function (event) {
    event.currentTarget.parentElement.remove();
  }

  $.TweetCompose.prototype.addMentionedUser = function (event) {
    this.$el.find(".mentioned-users")
      .append(
        $("<li>")
        .append(this.$el.find("script").html())
      );
  }

  $.TweetCompose.prototype.charsLeft = function (event){
    var charsLeft = 140 - event.currentTarget.value.length;

    if (charsLeft >= 0) {
      var text = charsLeft + " characters left";
    } else {
      var text = "Over the limit...";
    }

    this.$el.find(".chars-left").text(text);
  };

  $.TweetCompose.prototype.handleSubmit = function (event) {
    event.preventDefault();
    $.ajax({
      url: "/tweets",
      type: "post",
      dataType: "json",
      data: $(event.currentTarget).serialize(),
      success: this.handleSuccess.bind(this),
      error: this.handleError.bind(this)
    })
    this.toggleDisable(true);
  };

  $.TweetCompose.prototype.toggleDisable = function (boolean) {
    this.$el.find(":input").prop("disabled", boolean);
  }

  $.TweetCompose.prototype.handleSuccess = function (response) {
    this.clearInput();
    this.toggleDisable(false);

    // this.renderTweet(response);

    $("#feed").trigger("insert-tweet", [response])

    this.$el.find(".mentioned-users").empty();
    this.$el.find(".chars-left").text("");

  }

  $.TweetCompose.prototype.handleError = function () {
    this.toggleDisable(false);
    this.$el.find(".mentioned-users").empty();
    this.$el.find(".chars-left").text("");
  }

  $.TweetCompose.prototype.renderTweet = function (response) {
    var $ul = $(this.$el.data("tweets-ul"));

    var $tweet = $("<li>");
    $tweet.append(response.content)
      .append(" -- ")
      .append(makeLink(response))
      .append(" -- ")
      .append(response.created_at);

    var $mentioned = $("<ul>")

    response.mentions.forEach(function (mention) {
      $mentioned.append($("<li>").append(makeLink(mention)));
    });

    $ul.prepend($tweet.append($mentioned));
  }

  var makeLink = function (response) {
    return $("<a>").text(response.user.username).attr("href", "/users/" + response.user_id);
  }

  $.TweetCompose.prototype.clearInput = function(){
    this.$el.find("textarea").val("");
    this.$el.find("select").val("");
  }

  $.fn.tweetCompose = function () {
    return this.each(function () {
      new $.TweetCompose(this);
    });
  };



})();
