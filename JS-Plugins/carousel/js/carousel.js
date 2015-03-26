(function () {

  $.Carousel = function (el) {
    this.$carousel = $(el)
    this.activeIndex = 1;
    this.itemCount = this.$carousel.find(".items > li").length;
    this.transitioning = false;
  };

  $.Carousel.prototype.bindEvents = function () {
    var carousel = this;

    carousel.slide(0);

    carousel.$carousel.on("click", "a", function (event) {
      if (carousel.transitioning) {
        return;
      }
      if (event.currentTarget.classList[0] === "slide-left") {
        carousel.slide(-1);
      } else {
        carousel.slide(1);
      }

    } );
  }

  $.Carousel.prototype.deltaIndex = function (num) {

    var temporaryIndex = this.activeIndex + num

    if (temporaryIndex < 1) {
      temporaryIndex = this.itemCount;
    } else if (temporaryIndex > this.itemCount ) {
      temporaryIndex = 1;
    }

    return temporaryIndex;
  }


  $.Carousel.prototype.slide = function (num) {
    var carousel = this;
    this.transitioning = true;
    var active = this.$carousel.find(".items > li.active");
    active.removeClass("active right left");

    this.activeIndex = this.deltaIndex(num);

    var findCenter = ".items > li:nth-child(" + this.activeIndex + ")"
    var findLeft = ".items > li:nth-child(" + this.deltaIndex(-1) + ")"
    var findRight = ".items > li:nth-child(" + this.deltaIndex(1) + ")"

    this.$carousel.find(findCenter).addClass("active");
    this.$carousel.find(findLeft).addClass("active left");
    this.$carousel.find(findRight).addClass("active right");

    // alert("you slid " + num)
    setTimeout(function() { carousel.transitioning = false; }, 500);

  }






  $.fn.carousel = function () {
    return this.each(function () {
      var carousel = new $.Carousel(this);
      carousel.bindEvents();
    });
  };

})();
