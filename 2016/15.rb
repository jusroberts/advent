require "pry-byebug"

discs = [
  {length: 5, pos: 4},
  {length: 2, pos: 1}
]

discs = [
  {length: 17, pos: 5},
  {length: 19, pos: 8},
  {length: 7, pos: 1},
  {length: 13, pos: 7},
  {length: 5, pos: 1},
  {length: 3, pos: 0},
]

discs = [
  {length: 17, pos: 5},
  {length: 19, pos: 8},
  {length: 7, pos: 1},
  {length: 13, pos: 7},
  {length: 5, pos: 1},
  {length: 3, pos: 0},
  {length: 11, pos: 0},
]

time = 0

def are_the_stars_aligned(discs, time)
  t = time + 1
  discs.each do |disc|
    return false if ((disc[:pos] + t) % disc[:length]) != 0
    t += 1
  end
  return true
end

while(!are_the_stars_aligned(discs, time))
  time += 1
end
puts time