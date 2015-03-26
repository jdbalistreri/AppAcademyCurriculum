# ---- PROBLEM 13 ---- #

# Work out the first ten digits of the sum of the following one-hundred 50-digit numbers.

# ---- --------- ---- #

my_grid = IO.readlines('problem13.txt')
sum = 0
my_grid.each { |num| sum += num.to_i }

sum = sum.to_s

puts "First 10 digits are #{sum[0..9]}"
