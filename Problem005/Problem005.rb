# ---- PROBLEM 5 ---- #

# 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
#
# What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

# ---- --------- ---- #

product = 1

(1..20).each do |x| 
  next if product % x == 0
  i = 2
  while i < x do
    x /= i if (x % i == 0 && product % i == 0) 
    i += 1
  end
  product *= x
end

puts product