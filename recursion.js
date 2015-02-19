"use strict";

var recursiveRange = function(start, stop) {

  if(start === stop) {
    return [start];
  } else if(start > stop) {
    return [];
  } else {
    return [start].concat(recursiveRange((start+1), stop));
  }
};

var recursiveExp1 = function(b, n) {
  if(n === 0) {
    return 1;
  } else {
    return b * recursiveExp1(b, n-1);
  }
};

var recursiveExp2 = function(b, n) {
  if(n === 0) {
    return 1;
  } else if(n % 2 === 0) {
    var mid_result = recursiveExp2(b, n / 2);
    return mid_result * mid_result;
  } else {
    var mid_result = recursiveExp2(b, (n-1) / 2 );
    return mid_result * mid_result * b;
  }
};

var demFibs = function(n) {
  if(n === 0) {
    return [];
  } else if(n === 1) {
    return [1];
  } else if(n === 2) {
    return [1,1];
  } else {
    var previousFibs = demFibs(n-1);
    var last = previousFibs.length - 1;
    var secondLast = last - 1;
    var nextFib = previousFibs[last] + previousFibs[secondLast];
    return previousFibs.concat([nextFib]);
  }
};

var bSearch = function(array, target) {
  var len = array.length;

  if(len <= 1) {
    return array[0] === target ? 0 : null;
  } else {
    var middle_index = Math.floor(len / 2);
    var middle_value = array[middle_index]

    if(middle_value === target) {
      return middle_index;

    } else if(target < middle_value) {
      result = bSearch(array.slice(0,middle_index), target);
      return result;

    } else {
      var new_array = array.slice(middle_index + 1, len);
      result = bSearch(new_array, target);
      return result === null ? null : middle_index + 1 + result;
    }
  }
};

var numSort = function(a,b) {
  return a - b;
};

var minLengthItem = function(array) {
  var minLength = array[0].length;
  var minValue = null;

  for(var i in array) {
    var currentLength = array[i].length
    if(currentLength <= minLength) {
      minLength = currentLength;
      minValue = array[i];
    }
  };

  return minValue;
};


var makeChange = function(total, coins) {
  if(total === 0) return [];

  coins.sort(numSort).reverse();
  var changeOptions = [];

  for(var i in coins) {
    coin = coins[i];
    if(coin > total) continue;

    var current_coin = [coin]
    var rest_of_change = makeChange(total - coin, coins);
    var changeOption = current_coin.concat(rest_of_change);

    changeOptions.push(changeOption);
  };


  return minLengthItem(changeOptions);
};


var mergeSort = function(array) {
  if(array.length <= 1) {
    return array;
  } else {
    var mid_point = Math.floor(array.length / 2);
    var left_arr = array.slice(0,mid_point);
    var right_arr = array.slice(mid_point, array.length);

    var sorted_left = mergeSort(left_arr);
    var sorted_right = mergeSort(right_arr);

    return merge(sorted_left, sorted_right);
  }
};


var merge = function(left_arr, right_arr) {
  var sorted = []

  while(left_arr.length != 0 && right_arr.length != 0) {
    var left_el = left_arr[0];
    var right_el = right_arr[0];

    if(left_el < right_el) {
      sorted = sorted.concat(left_arr.shift());
    } else {
      sorted = sorted.concat(right_arr.shift());
    }
  };

  return sorted.concat(left_arr).concat(right_arr);
};



var subSets = function(arr) {
  if(arr.length === 0) return [[]];
  var current_el = arr.shift();

  var smallerSubsets = subSets(arr);

  var myConcat = function(el) {
    return el.concat([current_el]);
  };

  var largerSubsets = smallerSubsets.map(myConcat);

  console.log("smaller:" + smallerSubsets);
  console.log("larger:" + largerSubsets);

  return smallerSubsets.concat(largerSubsets);
};
