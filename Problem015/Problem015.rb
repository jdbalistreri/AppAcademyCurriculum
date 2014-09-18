# ---- PROBLEM 15 ---- #

# Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.
# How many such routes are there through a 20×20 grid?

# ---- --------- ---- #


#Note: the number of routes to get to a certain node is a grid is a function of Pascal's triangle. For example, there is one way to get to the start node [1], and there is one way to get to each of the nodes that comes from the start node [1,1]. However, on the third level there is one way to get to each outer node and two ways to get to the middle node [1,2,1]. If we go out two more levels, [1,3,3,1], and [1,4,6,4,1], we will find that the middle number of the 5th level, 6, is the number of routes through a 2x2 array. Similarly, the middle number of the 3rd level, 2, is the number of routes through a 1x1 array. Thus, the number of routes through an n x n grid is equivalent to the middle number of the (n x 2 + 1)th level of pascal's triangle.


tri_arr = [[1]]
n = 5
layer_depth = 40

layer_depth.times do
  prev_arr1 = [0] + tri_arr.last
  prev_arr2 = tri_arr.last + [0]
  next_arr = []
  prev_arr1.length.times {|x| next_arr << (prev_arr1[x] + prev_arr2[x]) }
  tri_arr << next_arr
end

puts tri_arr[40].max