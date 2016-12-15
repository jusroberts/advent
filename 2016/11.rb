require "pry-byebug"

input = "The first floor contains a hydrogen-compatible microchip and a lithium-compatible microchip.
The second floor contains a hydrogen generator.
The third floor contains a lithium generator.
The fourth floor contains nothing relevant.".split("\n")
input = "The first floor contains a strontium generator, a strontium-compatible microchip, a plutonium generator, and a plutonium-compatible microchip.
The second floor contains a thulium generator, a ruthenium generator, a ruthenium-compatible microchip, a curium generator, and a curium-compatible microchip.
The third floor contains a thulium-compatible microchip.
The fourth floor contains nothing relevant.".split("\n")
goal_length = 0
floors = input.map do |line|
  stuff = line.split('a ').map(&:chomp)
  generators = stuff.select { |s| s.include? 'generator' }
  chips = stuff.select { |s| s.include? 'microchip' }
  goal_length += generators.length + chips.length
  floor = []
  floor += generators.map do |gen|
    [:gen, gen.split(' ')[0].to_sym]
  end
  floor += chips.map do |chip|
    [:chip, chip.split('-')[0].to_sym]
  end
  floor
end
# goal_length = floors.flatten.length
initial_state = {elevator: 0, floors: floors}

def get_moves(current_state)
  next_states = []
  elevator = current_state[:elevator]
  current_floor = current_state[:floors][elevator]
  # binding.pry
  [-1, 1].each do |elevator_direction|
    (0..current_floor.length-1).each do |i|
      binding.pry if current_floor[i] == nil
      blah = is_move_valid(current_state.dup, {elevator: elevator_direction, inventory: [current_floor[i]]})
      next_states << blah if blah
      (i+1..current_floor.length-1).each do |j|
        blah = is_move_valid(current_state.dup, {elevator: elevator_direction, inventory: [current_floor[i], current_floor[j]]})
        next_states << blah if blah
      end
    end
  end
  # binding.pry
  next_states
end

#proposed_state = [[[:chip, :hydrogen], 1]] or [[[:chip, :hydrogen], 1], [[:chip, :lithium], 1]]
def is_move_valid(current_state, proposed_change)
  proposed_floor = current_state[:elevator] + proposed_change[:elevator]
  return false if proposed_change.length < 2 || proposed_change.length > 3
  return false if proposed_floor < 0 || proposed_floor > 3

  proposed_state = get_new_state(current_state, proposed_change)
  generators = []
  chips = []
  proposed_state[:floors][proposed_floor].each do |item|
    binding.pry if item == nil
    if item[0] == :gen
      generators << item[1]
    else
      chips << item[1]
    end
  end
  if generators.length > 0
    chips.each do |chip_type|
      return false if !generators.include?(chip_type)
    end
  end

  return false if @visited_states.include? proposed_state.to_s
  @visited_states << proposed_state.to_s
  # binding.pry
  proposed_state
end

def get_new_state(current_state, proposed_change)
  new_state = {}
  new_state[:elevator] = current_state[:elevator] + proposed_change[:elevator]
  new_state[:floors] = Array.new(4, [])
  current_state[:floors].each_with_index do |floor, i|
    f = floor.map do |item|
      item.map {|a| a}
    end
    if f
      new_state[:floors][i] = f
    end
  end
  proposed_change[:inventory].each do |item|
    binding.pry if new_state[:floors][new_state[:elevator]].nil?
    new_state[:floors][new_state[:elevator]] << item.map {|a| a}
    index = 0
    new_state[:floors][current_state[:elevator]].each_with_index do |thing, i|
      index = i if thing[0] == item[0] && thing[1] == item[1]
    end
    new_state[:floors][current_state[:elevator]].delete_at(index)
  end
  new_state[:floors].each do |floor|
    floor.sort_by! {|a| [a[0], a[1]] }
  end
  binding.pry if new_state[:floors][current_state[:elevator]].include? nil
  binding.pry if new_state[:floors][new_state[:elevator]].include? nil
  new_state
end

@steps = 0
current_states = [initial_state]
@visited_states = current_states.map {|s| s.to_s }
# binding.pry
done = false
moves = current_states.map do |state|
  get_moves(state)
end.flatten
# binding.pry

while moves.length != 0 && !done
  # binding.pry
  @steps += 1
  current_states = moves
  puts "current states: #{current_states.length}"

  moves = current_states.map do |state|
    # binding.pry if @steps == 11
    if state[:floors][3].length == goal_length
      done = true
      puts @steps
      break
    end
    get_moves(state)
  end.flatten
  # binding.pry
  # a = "asdf"
end
puts @steps
binding.pry

a = "asdf"