# ---- PROBLEM 9 ---- #

# A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
#
# a**2 + b**2 = c**2
# For example, 3**2 + 4**2 = 9 + 16 = 25 = 5**2.
#
# There exists exactly one Pythagorean triplet for which a + b + c = 1000.
# Find the product abc.


# ---- --------- ---- #

c = 998
while c > 0
  b = 1000 - c - 1
  while b > 0
    a = 1000 - c - b
    if (a**2 + b**2 == c**2)
      puts a*b*c 
      break
    end
    b -= 1
  end
  c -= 1
end
