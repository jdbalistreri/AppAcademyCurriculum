# ---- PROBLEM 17 ---- #

# If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
#
# If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?
#
#
# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.

# ---- --------- ---- #



def create_words num

  hash = { 1 => "one", 2 => "two", 3 => "three", 4 => "four",
    5 => "five", 6 => "six", 7 => "seven", 8 => "eight", 9 => "nine", 10 => "ten",
    11 => "eleven", 12 => "twelve", 13 => "thirteen", 14 => "fourteen", 15 => "fifteen",
    16 => "sixteen", 17 => "seventeen", 18 => "eighteen", 19 => "nineteen", 20 => "twenty",
    30 => "thirty", 40 => "forty", 50 => "fifty", 60 => "sixty", 70 => "seventy", 80 => "eighty",
  90 => "ninety"}

  output = ""
  dig1 = ( num / 1   ) % 10
  dig2 = ( num / 10  ) % 10
  dig3 = ( num / 100 ) % 10

  return "onethousand" if num == 1000

  output += "#{hash[dig3]}hundred" if dig3 > 0
  output += "and" if dig3 > 0 && (dig2 > 0 || dig1 > 0)

  #start with single digits and tens places
  if dig2 == 1
    output += hash[dig2 * 10 + dig1]
  else
    output += dig2 == 0 ? "#{hash[dig1]}" : "#{hash[dig2*10]}#{hash[dig1]}"
  end
  return output
end

sum = 0

(1..1000).each { |num| sum += (create_words num).length }

print sum




