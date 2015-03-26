# ---- PROBLEM 11 ---- #

# In the 20×20 grid below, four numbers along a diagonal line have been marked in red.
# The product of these numbers is 26 × 63 × 78 × 14 = 1788696.
#
# What is the greatest product of four adjacent numbers in the same direction (up, down, left, right, or diagonally) in the 20×20 grid?

# ---- ---------- ---- #



#PROBLEM 11


#test the grid horizontally
def horiz_test grid, line_size
  max_product = 0
  arr = []
  grid.each do |array|
    (array.length - line_size + 1).times do |i|
      product = 1
      array[i...(i+line_size)].each do |num|
        product *= num
      end
      if product > max_product
        max_product = product
        arr = array[i...(i+line_size)]
      end
    end
  end
  return max_product, arr
end

def vertical_flip my_grid
  flipped = []
  grid_width = my_grid[0].length
  grid_height = my_grid.length
  (grid_width).times do |x|
    next_arr = []
    (grid_height).times do |y|
      next_arr << my_grid[y][x]
    end
    flipped << next_arr
  end
  return flipped
end

#pull and create the grid
my_grid = IO.readlines('problem11.txt')
my_grid.map! { |array|
  array = array.split(" ")
  array.map! { |x| x.to_i }
}
grid_width = my_grid[0].length
grid_height = my_grid.length


#flip the grid so i can run horizontal trials vertically
vert_flip = vertical_flip my_grid

#create first diagonal flip
diag_flip1 = []
x = 0

39.times do |sum|
  next_arr = []
  n = sum <= 20 ? (sum + 1) : (41 - sum)
  x = sum < 20 ? 0 : sum - 19
  y = sum - x
  n.times do
    next_arr << my_grid[y][x]
    x += 1
    y -= 1
    break if x > 19 || y < 0
  end
  diag_flip1 << next_arr
end

#create second diagonal flip
diag_flip2 = []
sum = 20

39.times do |i|
  next_arr = []
  y, x = 0, 19 - i
  y, x = x.abs, 0 if x < 0
  while true
    next_arr << my_grid[y][x]
    x, y = x + 1, y + 1
    break if x >= 20 || y >= 20
  end
  diag_flip2 << next_arr
end


#run the flipped grid through the horiz_test
max1, arr1 = horiz_test my_grid, 4
max2, arr2 = horiz_test vert_flip, 4
max3, arr3 = horiz_test diag_flip1, 4
max4, arr4 = horiz_test diag_flip2, 4

print [max1, max2, max3, max4].max


#return maxproduct
