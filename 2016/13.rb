require "pry-byebug"

def is_wall?(x, y)
  val = x*x + 3*x + 2*x*y + y + y*y + 1358
  num_ones = val.to_s(2).split("").select { |a| a == "1" }.length
  # binding.pry
  return num_ones % 2 == 1
end

array = Array.new(55) { Array.new(55, " ") }

array.each_with_index do |a, y|
  a.each_with_index do |_, x|
    array[y][x] = '#' if is_wall?(x, y)
  end
end

x = 1
y = 1

target_x = 31
target_y = 39

# target_x = 7
# target_y = 4

array[target_y][target_x] = "A"
# array[y][x] = "X"

# array.each do |a|
#   puts a.join
# end

# while (true)
#   prev_x = x
#   prev_y = y
#   case gets
#   when "w\n"
#     y -= 1
#   when "s\n"
#     y += 1
#   when "a\n"
#     x -= 1
#   when "d\n"
#     x += 1
#   else
#     puts "ERROR on input"
#   end
#   if array[y][x] != "#"
#     if array[y][x] == "O"
#       array[prev_y][prev_x] = "."
#     else
#       array[prev_y][prev_x] = "O"
#     end
#   else
#     x = prev_x
#     y = prev_y
#   end
#   array[y][x] = "X"
#   puts array.flatten.select {|a| a == "O" || a == "X"}.length - 1
#   puts "WINNER" if x == target_x && y == target_y
#   array.each do |a|
#     puts a.join
#   end
#   if x == target_x && y == target_y
#     puts "WINNER"
#     puts array.flatten.select {|a| a == "O" || a == "X"}.length - 1
#     break
#   end
# end

active_pointers = [[1,1]]

step = 0
array[1][1] = "O"
def print(array, step)
  array.each do |a|
    puts a.join.gsub("O", "\e[31mO\e[0m")
  end
  puts array.flatten.select {|a| a == "O" || a == "X"}.length
  puts step
end

def is_pointer_available(p, array, new_pointers)
  return array[p[0]][p[1]] != "O" && array[p[0]][p[1]] != "#" && !new_pointers.include?(p) && p[0] >= 0 && p[1] >= 0
end
while step <= 500
  next_pointers = []
  active_pointers.each do |p|
    possibles = [[p[0] + 1, p[1]],
    [p[0] - 1, p[1]],
    [p[0], p[1] + 1],
    [p[0], p[1] - 1]]
    possibles.each do |a|
      if is_pointer_available(a, array, next_pointers)
        next_pointers << a 
        array[a[0]][a[1]] = "O"
      end
    end
  end
  active_pointers = next_pointers
  step += 1
  print(array, step)
  if array[target_y][target_x] == "O"
    break
  end
  gets
end