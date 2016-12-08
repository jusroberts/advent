NORTH = 0
EAST = 1
SOUTH = 2
WEST = 3

@compass = [{dir: :y, mult: 1}, {dir: :x, mult: 1}, {dir: :y, mult: -1}, {dir: :x, mult: -1}]
@current_direction = NORTH

@x = 0
@y = 0

route = "L4, L3, R1, L4, R2, R2, L1, L2, R1, R1, L3, R5, L2, R5, L4, L3, R2, R2, L5, L1, R4, L1, R3, L3, R5, R2, L5, R2, R1, R1, L5, R1, L3, L2, L5, R4, R4, L2, L1, L1, R1, R1, L185, R4, L1, L1, R5, R1, L1, L3, L2, L1, R2, R2, R2, L1, L1, R4, R5, R53, L1, R1, R78, R3, R4, L1, R5, L1, L4, R3, R3, L3, L3, R191, R4, R1, L4, L1, R3, L1, L2, R3, R2, R4, R5, R5, L3, L5, R2, R3, L1, L1, L3, R1, R4, R1, R3, R4, R4, R4, R5, R2, L5, R1, R2, R5, L3, L4, R1, L5, R1, L4, L3, R5, R5, L3, L4, L4, R2, R2, L5, R3, R1, R2, R5, L5, L3, R4, L5, R5, L3, R1, L1, R4, R4, L3, R2, R5, R1, R2, L1, R4, R1, L3, L3, L5, R2, R5, L1, L4, R3, R3, L3, R2, L5, R1, R3, L3, R2, L1, R4, R3, L4, R5, L2, L2, R5, R1, R2, L4, L4, L5, R3, L4"
directions = route.split(", ")


def apply_direction(direction)
  change_direction = direction[0] == "L" ? -1 : 1;
  movement = direction[1,direction.length - 1].to_i
  @current_direction = (@current_direction + change_direction) % 4
  orientation = @compass[@current_direction]
  if orientation[:dir] == :y
    @y = @y + (movement * orientation[:mult])
  else
    @x = @x + (movement * orientation[:mult])
  end
end

directions.each do |direction|
  apply_direction(direction)
end

puts @x + @y


@x = 500
@y = 500

class Array2D
  attr_accessor :data
  def initialize(width, height)
    @data = Array.new(width) { Array.new(height) }
  end

  def [](x,y)
    @data[x][y]
  end

  def []=(x,y,value)
    @data[x][y] = value
  end
end

@city = Array2D.new(@x*2, @y*2)
@city[@x,@y] = 1
#route = "R8, R4, R4, R8"
#directions = route.split(", ")

def apply_direction_and_mark(direction)
  change_direction = direction[0] == "L" ? -1 : 1
  movement = direction[1, direction.length - 1].to_i
  @current_direction = (@current_direction + change_direction) % 4
  orientation = @compass[@current_direction]
  (1..movement).each do |move|
    x = @x
    y = @y
    if orientation[:dir] == :y
      y = @y + (move * orientation[:mult])
    else
      x = @x + (move * orientation[:mult])
    end
    if @city[x,y] == 1
      puts (x-500).abs + (y-500).abs
    else
      @city[x,y] = 1
    end
  end
  if orientation[:dir] == :y
    @y = @y + (movement * orientation[:mult])
  else
    @x = @x + (movement * orientation[:mult])
  end
end

@current_direction = NORTH
directions.each do |direction|
  apply_direction_and_mark(direction)
end

@city.data.each do |x|
  puts @city.data[x]
end

