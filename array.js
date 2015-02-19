
"use strict";

Array.prototype.includes = function(target) {
  for(var i in this) {
    if(this[i] === target) {
      return true;
    };
  };
  return false;
};

Array.prototype.uniq = function() {
  var output = [];

  for(var num of this) {
    if(!output.includes(num)) {
      output.push(num);
    }
  };

  return output;
};

Array.prototype.twoSum = function() {
  var output = [];

  for(i in this) {
    for(j in this) {
      if( (i < j) && (this[i] + this[j] === 0) ) {
        output.push([i,j]);
      }
    };
  };

  return output;
};

Array.prototype.transpose = function() {
  var numRows = this.length;
  var numCols = this[0].length;
  var transposed = [];

  for(var row = 0; row < numRows; row++) {
    var newRow = [];

    for(var col = 0; col < numCols; col++) {
      newRow.push(this[col][row]);
    };

    transposed.push(newRow);
  };

  return transposed;
};
