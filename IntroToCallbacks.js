function Clock () {
}

Clock.TICK = 2000;

Clock.prototype.printTime = function () {
  var time = this.hours + ":" + this.minutes + ":" + this.seconds;
  console.log(time);
};

Clock.prototype.run = function () {
  var firstDate = new Date();

  this.seconds = firstDate.getSeconds();
  this.minutes = firstDate.getMinutes();
  this.hours = firstDate.getHours();

  this.printTime();

  // 3. Schedule the tick interval.
  setInterval(this._tick.bind(this), Clock.TICK);
};

Clock.prototype._tick = function () {
  this.seconds += Clock.TICK/1000;
  if (this.seconds >= 60) {
    this.seconds -= 60;
    this.minutes += 1;

    if (this.minutes >= 60) {
      this.minutes -= 60;
      this.hours += 1;

      if (this.hours >= 24) {
        this.hours -= 24;
      }
    }
  }

  this.printTime();
};

// var clock = new Clock();
// clock.run();














// var readline = require('readline');
//
// var reader = readline.createInterface({
//   input: process.stdin,
//   output: process.stdout
// });


var addNumbers = function(sum, numsLeft, completionCallback) {
  if (numsLeft === 0) {
    completionCallback(sum);
    reader.close();
    return;
  }

  reader.question("Give me a number: ", function(answer){
    var number = parseInt(answer);
    sum += number;

    console.log("The current sum is: " + sum);
    addNumbers(sum, numsLeft - 1, completionCallback);
  });


}
// addNumbers(0, 3, function (sum) {
//   console.log("Total Sum: " + sum);
// });













var readline = require("readline");

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function askIfGreaterThan (el1, el2, callback) {
  // Prompt user to tell us whether el1 > el2; pass true back to the
  // callback if true; else false.
  var questi = "Is " + el1 + " greater than " + el2 + "?  "

  reader.question(questi, function (answer) {
    callback(answer.toLowerCase() === "yes");
  });
};

function innerBubbleSortLoop (arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i < arr.length - 1) {
    askIfGreaterThan( arr[i], arr[i+1], function (isGreaterThan) {
      if (isGreaterThan) {
        var tmp = arr[i];
        arr[i] = arr[i + 1];
        arr[i + 1] = tmp;
        madeAnySwaps = true;
      }
      innerBubbleSortLoop(arr, i + 1, madeAnySwaps, outerBubbleSortLoop);
    });

  } else {
    outerBubbleSortLoop(madeAnySwaps);
  }
};

function absurdBubbleSort (arr, sortCompletionCallback) {
  function outerBubbleSortLoop (madeAnySwaps) {
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
      return;
    }
  };

  outerBubbleSortLoop(true);
};

absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
