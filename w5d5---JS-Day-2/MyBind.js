Function.prototype.myBind = function (context) {
  var fn = this;
  return function () {
    return fn.apply(context);
  };
};


function Cat(name) {
  this.name = name;
};

Cat.prototype.hi = function() {
  return "hi i am " + this.name;
};

c = new Cat("c!!");

var hiFunc = c.hi.myBind(c);

hiFunc();
