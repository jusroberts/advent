input = "..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#".split("\n")
input = File.read("3.input").split("\n")


class Position 
    attr_accessor :x, :y, :slope_x, :slope_y, :width, :tree_count
    def initialize(slope_x, slope_y, width)
        @x = 0
        @y = 0
        @slope_x = slope_x
        @slope_y = slope_y
        @width = width
        @tree_count = 0
    end

    def iterate
        @x += @slope_x
        @x %= @width
        @y += @slope_y
    end
end

width = input[0].size
slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
positions = slopes.map {|a| Position.new(a[0], a[1], width)}
TREE = "#"

(0..input.size-1).each do |i|
    positions.each do |position|
        next if position.y > input.size-1
        position.tree_count += 1 if input[position.y][position.x] == TREE


        position.iterate
    end
end
tree_product = 1
positions.each do |position|
    p "[#{position.slope_x} #{position.slope_y}] : #{position.tree_count}"
    tree_product *= position.tree_count
end
p tree_product