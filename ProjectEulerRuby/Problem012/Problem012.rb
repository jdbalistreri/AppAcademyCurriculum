# ---- PROBLEM 12 ---- #

# The sequence of triangle numbers is generated by adding the natural numbers. So the 7th triangle number would be 1 + 2 + 3 + 4 + 5 + 6 + 7 = 28. The first ten terms would be:
#
# 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
#
# Let us list the factors of the first seven triangle numbers:
# 1: 1
#  3: 1,3
#  6: 1,2,3,6
# 10: 1,2,5,10
# 15: 1,3,5,15
# 21: 1,3,7,21
# 28: 1,2,4,7,14,28
# We can see that 28 is the first triangle number to have over five divisors.
#
# What is the value of the first triangle number to have over five hundred divisors?

# ---- ---------- ---- #


def num_divisors num
  result = 0
  (1..(Math.sqrt(num)).round).each do |x|
    result += 2 if num % x == 0
  end
  return result
end

t1 = Time.now.to_f
tnum = 1
i = 1
target = 500

while true
  i += 1
  tnum += i
  if (num_divisors tnum)  > target
    puts "RESULT IS:"
    puts tnum
    puts "Project Euler problem 12: Answer found in #{((Time.now.to_f - t1) * 1000).round 3} ms."
    break
  end
end
