"use strict";

Array.prototype.bubbleSort = function() {
  var sorted = false;
  var arr = this;

  var oneIteration = function() {
    for(var i = 0; i < arr.length - 1; i++) {
      var first = arr[i]
      var second = arr[i+1]

      if( first > second ) {
        console.log(arr);
        sorted = false;
        arr[i] = second;
        arr[i+1] = first;
      }
    };
  };

  while(!sorted) {
    sorted = true;
    oneIteration();
  };

  return arr;
};


String.prototype.subStrs = function() {
  var output = [];

  for( var i = 0; i < this.length; i++ ) {
    for( var j = 0; j <= this.length; j++ ) {
      if(i < j) {
        output.push(this.substring(i,j));
      }
    };
  };

  return output
};
