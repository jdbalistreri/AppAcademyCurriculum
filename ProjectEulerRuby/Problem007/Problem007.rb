# ---- PROBLEM 7 ---- #

# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
#
# What is the 10_001st prime number?

# ---- --------- ---- #


def is_prime n
  (2..Math.sqrt(n)).each { |x| return false if n % x == 0}
  return false if n == 1
  return true
end

target_prime = 10_001
i = 0
test_number = 2

while true
  i += 1 if is_prime(test_number)
  break if i == target_prime
  test_number += 1
end

print test_number
