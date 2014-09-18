# ---- PROBLEM 19 ---- #

# You are given the following information, but you may prefer to do some research for yourself.
#
# 1 Jan 1900 was a Monday.
# Thirty days has September,
# April, June and November.
# All the rest have thirty-one,
# Saving February alone,
# Which has twenty-eight, rain or shine.
# And on leap years, twenty-nine.
# A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.
# How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?

# ---- ---------- ---- #

# go through each day from the start to the end time


day = 1
month = 1
year = 1990

#define a function that will increase the date by one day

def is_leap_year year
  return true if year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)
  return false
end

def next_day (month, day, year, day_of_week)
  days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
  i = days.index(day_of_week)
  i += 1
  i = 0 if i > 6

  months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  months[1] = 29 if is_leap_year(year)

  day += 1
  if day > months[month-1]
    day = 1
    month += 1
  end
  if month > 12
    month = 1
    year += 1
  end
  return month, day, year, days[i]
end


#keep track of which day of the week it is

def next_day_of_week str

end


#add to the counter if it is the first of the month and it is a sunday
month = 1
day = 1
year = 1901
day_of_week = "Tuesday"
count = 0
while year < 2001
  month, day, year, day_of_week = next_day(month,day,year, day_of_week)
  count += 1 if day == 1 && day_of_week == "Sunday"
end

print count

