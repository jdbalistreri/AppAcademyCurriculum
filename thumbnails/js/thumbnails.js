(function () {

  $.Thumbnails = function (el) {
    this.$thumbnails = $(el);
    this.$activeImg = this.$thumbnails.find(".active");
    this.activeSrc = null
    this.gutterIndex = 7;
  };

  $.Thumbnails.prototype.bindEvents = function () {
    var firstPicString = ".gutter-images > li:nth-child(" + this.gutterIndex + ") > img";
    var firstPic = this.$thumbnails.find(firstPicString);
    this.$activeImg.attr("src", firstPic.attr("src"));
    this.activeSrc = this.$activeImg.attr("src");
    this.fillGutterImages();


    this.$thumbnails.on("mouseover", "li > img", this.active.bind(this));
    this.$thumbnails.on("click", "li > img", this.active.bind(this));
  }

  $.Thumbnails.prototype.active = function (event) {
    var linkAddress = $(event.currentTarget).attr('src')
    this.$activeImg.attr("src", linkAddress);
    if (event.type === "click") { this.activeSrc = linkAddress }
    this.$thumbnails.one("mouseleave", "li > img", this.reset.bind(this));
  }

  $.Thumbnails.prototype.reset = function (event) {
    this.$activeImg.attr("src", this.activeSrc)
  }

  $.Thumbnails.prototype.fillGutterImages = function() {
    this.$thumbnails.find(".gutter-images > li").removeClass("displayed");

    for (var i = 0; i < 5; i++) {
      var currentIndex = this.gutterIndex + i
      currentIndex = currentIndex > 10 ? currentIndex - 10 : currentIndex;
      currentIndex = currentIndex < 1 ? 10 : currentIndex;

      var searchString = ".gutter-images > li:nth-child(" + currentIndex + ")"
      this.$thumbnails.find(searchString).addClass("displayed")
    }
  }


  $.fn.thumbnails = function () {
    return this.each(function () {
      var thumbs = new $.Thumbnails(this);
      thumbs.bindEvents();
    })
  }

})();
