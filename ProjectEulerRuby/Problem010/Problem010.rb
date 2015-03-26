# ---- PROBLEM 10 ---- #
# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
#
# Find the sum of all the primes below two million.

# ---- ---------- ---- #

def sum_primes max_number
  sum = 2
  (3..max_number).each do |test_num|
    next if test_num.even?
    prime = true
    # sqrttest = test_num**0.5
    (2..Math.sqrt(test_num)).each do |factor|
      prime = false if (test_num % factor == 0)
      break unless prime
    end
    sum += test_num if prime
    #puts test_num if prime
  end
  return sum
end




puts sum_primes 2000000






