# ---- PROBLEM 4 ---- #

# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
#
# Find the largest palindrome made from the product of two 3-digit numbers.

# ---- --------- ---- #


#note: the max product of two 3-digit numbers if 999*999 = 998001, so any palindrome that is a product of two 3-digit numbers must be <= 998001; the first palindrome below that value is 997799, so we will start with that number

def smaller_palindrome p
  p_str = p.to_s
  l = p_str.length
  raise "Not a palindrome" unless p_str.reverse == p_str
  
  first_half = l.even? ? (p_str[0...l/2].to_i - 1).to_s :
                         (p_str[0.. l/2].to_i - 1).to_s
  (first_half + first_half[0,l/2].reverse).to_i
end


def has_3dig_factor_pair n
  (100..999).each { |x| return true if n % x == 0 && (n/x).to_s.length == 3 }
  return false
end


test_number = 997799
while test_number > 0
  if has_3dig_factor_pair test_number
    puts test_number
    break
  end
  test_number = smaller_palindrome test_number
end