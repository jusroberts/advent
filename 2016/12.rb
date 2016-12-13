require "pry-byebug"

class String
  def is_number?
    true if Float(self) rescue false
  end
end

input = "cpy 41 a
inc a
inc a
dec a
jnz a 2
dec a"
input = "cpy 1 a
cpy 1 b
cpy 26 d
jnz c 2
jnz 1 5
cpy 7 c
inc d
dec c
jnz c -2
cpy a c
inc a
dec b
jnz b -2
cpy c b
dec d
jnz d -6
cpy 16 c
cpy 17 d
inc a
dec d
jnz d -2
dec c
jnz c -5"

instructions = input.split("\n").map { |line| line.split(" ") }
@registers = {"a" => 0, "b" => 0, "c" => 1, "d" => 0}

def run_loop(instructions)
  pointer = 0
  while pointer >= 0 && pointer < instructions.length
    pointer_increment = 1
    instruction = instructions[pointer]
    case(instruction[0])
      when "cpy"
        cpy(instruction[1], instruction[2])
      when "inc"
        inc(instruction[1])
      when "dec"
        dec(instruction[1])
      when "jnz"
        val = jnz(instruction[1], instruction[2])
        pointer_increment = val if val != 0
      else
        puts "ERROR: #{instuction[0]} #{instuction[1]} #{instuction[2]}"
    end
    pointer += pointer_increment
  end
end

def cpy(x, y)
  val = 0
  if x.is_number?
    val = x.to_i
  else
    val = @registers[x]
  end
  @registers[y] = val
end

def inc(x)
  @registers[x] += 1
end

def dec(x)
  @registers[x] -= 1
end

def jnz(x, y)
  ret = false
  if x.is_number?
    ret = x.to_i != 0
  else
    ret = @registers[x] != 0
  end
  return y.to_i if ret
  return 0
end

run_loop(instructions)

puts @registers["a"]
a = "asdf"