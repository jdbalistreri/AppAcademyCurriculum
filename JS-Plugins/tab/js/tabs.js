(function () {
  $.Tabs = function (el) {
    this.$tabs = $(el)
    this.$contentTabs = $($(el).data("content-tabs"))
    this.$activeTab = this.$contentTabs.find(".active")
  };

  $.Tabs.prototype.clickTab = function(event) {
    event.preventDefault();
    var link = event.currentTarget;
    var tabs = this;

    // LINK
    this.$tabs.find("li > a").removeClass("active");
    $(link).addClass("active");

    // TAB PANE
    var $oldPane = this.$activeTab;
    $oldPane.removeClass("active");
    $oldPane.addClass("transitioning");

    $oldPane.one("transitionend", function () {
      $oldPane.removeClass("transitioning");

      var $newPane = $($(link).attr('href'));

      $newPane.addClass("active transitioning");
      setTimeout(function () {
        $newPane.removeClass("transitioning");
      }, 0);

      tabs.$activeTab = $newPane;
    })
  }

  $.Tabs.prototype.createListener = function() {
    this.$tabs.on("click", "a", this.clickTab.bind(this))

  }

  $.fn.tabs = function () {
    return this.each(function () {
      var tabs = new $.Tabs(this);
      tabs.createListener();
    });
  };
})();

// Cat = function (age) {
//   this.age = age
// }
//
// Cat.prototype.ageOneYr = function() {
//   this.age++
// }
//
// var sayTimes = function (num, callback) {
//   while (num > 0) {
//     callback("tommy")
//     num--
//   }
// }
//
// sennacy = new Cat(3);
//
// var callback = function () {
//   this.ageOneYr()
// }.bind(sennacy)
//
// var fn = function (string) {
//   console.log(string)
// };
//
// times(10, fn)
