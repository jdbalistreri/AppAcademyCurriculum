(function (){
  $.TweetCompose = function (el) {
    this.$el = $(el);
    this.bindEvents();
  };

  $.TweetCompose.prototype.bindEvents = function () {
    this.$el.on("submit", this.handleSubmit.bind(this))
    this.$el.on("input", "textarea", this.charsLeft.bind(this))
  };

  $.TweetCompose.prototype.charsLeft = function (event){
    var charsLeft = 140 - event.currentTarget.value.length;

    if (charsLeft >= 0) {
      var text = charsLeft + " characters left";
    } else {
      var text = "Over the limit...";
    }

    this.$el.find(".chars-left").text(text);
  }

  $.TweetCompose.prototype.handleSubmit = function (event) {
    event.preventDefault();
    $.ajax({
      url: "/tweets",
      type: "post",
      dataType: "json",
      data: $(event.currentTarget).serialize(),
      success: this.handleSuccess.bind(this),
      failure: this.toggleDisable(false)
    })
    this.toggleDisable(true);
  };

  $.TweetCompose.prototype.toggleDisable = function (boolean) {
    this.$el.find(":input").prop("disabled", boolean);
  }

  $.TweetCompose.prototype.handleSuccess = function (response) {
    this.clearInput();
    this.toggleDisable(false);

    this.renderTweet(response);
  }

  $.TweetCompose.prototype.renderTweet = function (response) {
    var $ul = $(this.$el.data("tweets-ul"));
    var $tweet = $("<li>").append(response.content).append(" -- ");
    var $link = makeLink(response);
    $tweet.append($link).append(" -- ").append(response.created_at);

    var $mentioned = $("<ul>")

    response.mentions.forEach(function (mention) {
      $mentioned.append($("<li>").append(makeLink(mention)));
    });

    $tweet.append($mentioned);
    $ul.prepend($tweet);
  }

  var makeLink = function (response) {
    return $("<a>").text(response.user.username).attr("href", "/users/" + response.user_id);
  }

  $.TweetCompose.prototype.clearInput = function(){
    this.$el.find("textarea").val("");
    this.$el.find("select").prop('selectedIndex', 0);
  }

  $.fn.tweetCompose = function () {
    return this.each(function () {
      new $.TweetCompose(this);
    });
  };



})();
