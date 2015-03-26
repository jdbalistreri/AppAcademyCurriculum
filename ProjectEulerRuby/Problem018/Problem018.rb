# ---- PROBLEM 18 ---- #

# By starting at the top of the triangle below and moving to adjacent numbers on the row below (triangle1.txt), the maximum total from top to bottom is 23.
#
# That is, 3 + 7 + 4 + 9 = 23.
#
# Find the maximum total from top to bottom of the triangle below (triangle2.txt)
#
# NOTE: As there are only 16384 routes, it is possible to solve this problem by trying every route. However, Problem 67, is the same challenge with a triangle containing one-hundred rows; it cannot be solved by brute force, and requires a clever method! ;o)

# ---- --------- ---- #


tri_arr = IO.readlines("triangle2.txt")
tri_arr.map! { |str| str.split(" ").map! {|x| x.to_i }}

(tri_arr.length - 1).times do |i|
  (tri_arr[i + 1].length).times do |j|
    left = tri_arr[i][j - 1] == nil ? 0 : tri_arr[i][j - 1]
    right = tri_arr[i][j] == nil ? 0 : tri_arr[i][j]
    tri_arr[i + 1][j] += left > right ? left : right
  end
end

print tri_arr.last.max