require "pry-byebug"
input = File.readlines("6.in")
# input = "1, 1
# 1, 6
# 8, 3
# 3, 4
# 5, 5
# 8, 9".split("\n")

def get_array_bounds(input)
    largest = [0,0]
  
    input.each do |i|
      coords = to_coords(i)
      largest[0] = [coords[0], largest[0]].max
      largest[1] = [coords[1], largest[1]].max
    end

    largest
end

def to_coords(str) 
    x = str.split(", ")[0].to_i
    y = str.split(", ")[1].to_i
    [x,y]
end

def get_distance(p1, p2)
  (p1[0]-p2[0]).abs + (p1[1] - p2[1]).abs
end

def is_infinite(c, bounds)
    c[0] == 0 || c[1] == 0 || c[0] == bounds[0] || c[1] == bounds[1]
end

def min_distance(vals)
    min = 999999999
    val = []
    vals.each do |k, v|
        if v < min
            val = [k]
            min = v
        elsif v == min
            val[1] = k
        end
    end
    return val.size == 1 ? val[0] : "."

end

def part1(input)
    grid = []
    bounds = get_array_bounds(input)
    count_of_each = {}
    input.each_with_index {|_, i| count_of_each[i] = {inf: false, count: 0}}
    (0..bounds[0]).each do |i|
        grid[i] = []
    end

    (0..bounds[0]).each do |i|
        (0..bounds[1]).each do |j|
            point = [i,j]
            vals = {}
            input.each_with_index do |str, index|
                vals[index] = get_distance(point, to_coords(str))
            end
            index = min_distance(vals)
            grid[i][j] = index
            if index != "."
                count_of_each[index][:inf] ||= is_infinite(point, bounds)
                count_of_each[index][:count] += 1
            end
        end
    end

    p count_of_each
    str = ""
    str = grid.map do |g|
        g.join("")
    end.join("\n")
    puts str

    p count_of_each.map {|k, v| v[:inf] ? 0 : v[:count]}.sort[-1]
end


def part2(input)
    grid = []
    bounds = get_array_bounds(input)
    safe_count = 0

    (0..bounds[0]).each do |i|
        grid[i] = []
    end

    (0..bounds[0]).each do |i|
        (0..bounds[1]).each do |j|
            point = [i,j]
            vals = {}
            is_safe = true
            distance = 0
            input.each_with_index do |str, index|
                distance += get_distance(point, to_coords(str))
            end
            is_safe = distance < 10000
            index = min_distance(vals)
            grid[i][j] = is_safe ? "#" : " "
            safe_count += is_safe ? 1 : 0
        end
    end

    p safe_count
    str = ""
    str = grid.map do |g|
        g.join("")
    end.join("\n")
    puts str
    p safe_count
end

part2(input)