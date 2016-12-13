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

def get_moves(floors)

end

moves = []
current_state = []

binding.pry

a = "asdf"