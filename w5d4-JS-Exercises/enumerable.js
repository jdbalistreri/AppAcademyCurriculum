"use strict";


Array.prototype.myEach = function(proc) {
  for(el of this) {
    proc(el);
  };

  return this;
};

Array.prototype.myMap = function(func) {
  var mapped = [];

  var grabReturnValue = function(el) {
    mapped.push(func(el));
  };

  this.myEach(grabReturnValue);

  return mapped;
};


Array.prototype.myInject = function(func, accum) {

  var accumulateValues = function(el) {
    accum = func(accum, el);
  };

  this.myEach(accumulateValues);
  return accum;
}
