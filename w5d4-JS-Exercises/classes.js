
Array.prototype.includes = function(target) {
  for(var i in this) {
    if(this[i] === target) {
      return true;
    };
  };
  return false;
};

var Student = function(fName, lName) {
  this.fName = fName;
  this.lName = lName;
  this.courses = [];
};

var Course = function(name, department, numCredits, block, days) {
  this.name = name;
  this.department = department;
  this.numCredits = numCredits;
  this.students = [];
  this.block = block;
  this.days = days;
};

Student.prototype.name = function() {
  return this.fName + " " + this.lName;
};

Student.prototype.enroll = function(course) {
  this.courses.push(course);
  course.students.push(this);
};

Course.prototype.addStudent = function(student) {
  student.enroll(this);
};

Course.prototype.conflictsWith = function(otherCourse) {
  if(this.block != otherCourse.block) return false;

  for(var i in this.days) {
    day = this.days[i];
    if(otherCourse.days.includes(day)) return true;
  };

  return false;
};
