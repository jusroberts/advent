require "pry-byebug"

input = "The first floor contains a hydrogen-compatible microchip and a lithium-compatible microchip.
The second floor contains a hydrogen generator.
The third floor contains a lithium generator.
The fourth floor contains nothing relevant.".split("\n")

floors = input.map do |line|
  stuff = line.split('a ').map(&:chomp)
  generators = stuff.select { |s| s.include? 'generator' }
  chips = stuff.select { |s| s.include? 'microchip' }
  floor = []
  floor += generators.map do |gen|
    [:gen, gen.split(' ')[0].to_sym]
  end
  floor += chips.map do |chip|
    [:chip, chip.split('-')[0].to_sym]
  end
  floor
end

initial_state = {elevator: 0, floors: floors}

def get_moves(floors)

end

#proposed_state = [[[:chip, :hydrogen], 1]] or [[[:chip, :hydrogen], 1], [[:chip, :lithium], 1]]
def is_move_valid(current_state, proposed_change)
  proposed_floor = current_state[:elevator] + proposed_change[:elevator]
  return false if proposed_change.length < 2 || proposed_change.length > 3
  return false if proposed_floor < 0 || proposed_floor > 4
  proposed_state = get_new_state(current_state, proposed_change)
  proposed_state[:floors].each do |item|
    if item[:]
  end
end

def get_new_state(current_state, proposed_change)
  new_state = current_state.clone
  new_state[:elevator] += proposed_change[:elevator]
  proposed_change[:]
  new_state[:floors][current_state[:elevator]].delete()
end

moves = []
current_state = []

binding.pry

a = "asdf"