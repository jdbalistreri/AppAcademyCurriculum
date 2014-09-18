# ---- PROBLEM 23 ---- #

# Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
# If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called amicable numbers.
#
# For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
#
# Evaluate the sum of all the amicable numbers under 10000.

# ---- ---------- ---- #

#Test integers 1 - 28123


#def a function to determine whether or not a number is abundant
def is_abundant n
  sum = 0
  (1..n/2).each { |x| sum += x if n % x == 0}
  if sum > n 
    return true
  end
  return false
end

#create an array of abundant numbers below 28123

abundant_nums_arr = []

(12..28123).each { |x| abundant_nums_arr << x if is_abundant(x) }

#create a larger array of every unique sum of two numbers from the abundant number array if the number is <28123

sums_arr = []

(abundant_nums_arr.length).times do |i|
  (abundant_nums_arr.length).times do |j|
    sum = abundant_nums_arr[i] + abundant_nums_arr[j]
    break if sum > 28123
    sums_arr << sum
  end
end

sums_arr.uniq!

#sum all numbers <28123 that are not in the abundant sums array

result_sum = 0

(1..28123).each { |x| result_sum += x unless sums_arr.include?(x) }

print result_sum