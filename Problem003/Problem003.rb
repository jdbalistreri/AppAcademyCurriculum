# ---- PROBLEM 3 ---- #

# The prime factors of 13195 are 5, 7, 13 and 29.
#
# What is the largest prime factor of the number 600851475143 ?

# ---- --------- ---- #



n = 600851475143
prime_factors = []
test_number = 2

while n > 1
  if n % test_number == 0
    prime_factors << test_number
    n /= test_number
    test_number = 2
  else
    test_number += 1
  end
end

puts prime_factors.max