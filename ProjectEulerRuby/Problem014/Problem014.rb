# ---- PROBLEM 14 ---- #

# The following iterative sequence is defined for the set of positive integers:
#
# n → n/2 (n is even)
# n → 3n + 1 (n is odd)
#
# Using the rule above and starting with 13, we generate the following sequence:
#
# 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
# It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.
#
# Which starting number, under one million, produces the longest chain?
#
# NOTE: Once the chain starts the terms are allowed to go above one million.


# ---- --------- ---- #


n = 1000000
max_count = 0
max_num = 0

(1..n).each do |x|
  count = 1
  test_num = x
  while test_num != 1
    test_num = test_num.even? ? (test_num / 2) : (test_num * 3 + 1)
    count += 1
  end
  max_num, max_count = x, count if count > max_count
end

puts max_num, max_count
