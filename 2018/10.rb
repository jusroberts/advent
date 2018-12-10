require "pry-byebug"

input = File.readlines("10.in")
# input = "position=< 9,  1> velocity=< 0,  2>
# position=< 7,  0> velocity=<-1,  0>
# position=< 3, -2> velocity=<-1,  1>
# position=< 6, 10> velocity=<-2, -1>
# position=< 2, -4> velocity=< 2,  2>
# position=<-6, 10> velocity=< 2, -2>
# position=< 1,  8> velocity=< 1, -1>
# position=< 1,  7> velocity=< 1,  0>
# position=<-3, 11> velocity=< 1, -2>
# position=< 7,  6> velocity=<-1, -1>
# position=<-2,  3> velocity=< 1,  0>
# position=<-4,  3> velocity=< 2,  0>
# position=<10, -3> velocity=<-1,  1>
# position=< 5, 11> velocity=< 1, -2>
# position=< 4,  7> velocity=< 0, -1>
# position=< 8, -2> velocity=< 0,  1>
# position=<15,  0> velocity=<-2,  0>
# position=< 1,  6> velocity=< 1,  0>
# position=< 8,  9> velocity=< 0, -1>
# position=< 3,  3> velocity=<-1,  1>
# position=< 0,  5> velocity=< 0, -1>
# position=<-2,  2> velocity=< 2,  0>
# position=< 5, -2> velocity=< 1,  2>
# position=< 1,  4> velocity=< 2,  1>
# position=<-2,  7> velocity=< 2, -2>
# position=< 3,  6> velocity=<-1, -1>
# position=< 5,  0> velocity=< 1,  0>
# position=<-6,  0> velocity=< 2,  0>
# position=< 5,  9> velocity=< 1, -2>
# position=<14,  7> velocity=<-2,  0>
# position=<-3,  6> velocity=< 2, -1>".split("\n")

def decode(line)
    split = line.split(/[<>,]/)
    return {pos: [split[1].to_i, split[2].to_i], vel: [split[4].to_i, split[5].to_i]}
end

def get_distance(p1, p2)
    return Math.sqrt((p1[0] - p2[0]) * (p1[0] - p2[0]) + (p1[1] - p2[1]) * (p1[1] - p2[1]))
end

def move_points()
    @iteration += 1
    @points.each do |point|
        point[:pos][0] += point[:vel][0]
        point[:pos][1] += point[:vel][1]
    end
end

def get_array_bounds()
    largest = [0,0]
  
    @points.each do |point|
      coords = point[:pos]
      largest[0] = [coords[0], largest[0]].max
      largest[1] = [coords[1], largest[1]].max
    end

    largest
end

def print
    bounds = get_array_bounds
    grid = []
    (0..bounds[1]).each do |i|
        grid[i] = Array.new(bounds[0], ".")
    end

    @points.each do |point|
        pos = point[:pos]
        grid[pos[1]][pos[0]] = "#"
    end

    str = ""
    str = grid.map do |g|
        g.join("")
    end.join("\n")
    puts str
    puts @iteration
end

@points = input.map {|i| decode(i)}
@iteration = 0
while get_distance(@points[0][:pos], @points[1][:pos]) > 100
    move_points()
end

binding.pry

print

