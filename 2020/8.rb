require "set"
input="nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6"

input = File.read "8.input"
instructions = input.split("\n")


accumulator = 0
pointer = 0
set = Set.new
set.add(pointer)
num_fixes = 0
fixed_pointers = Set.new
tried_to_fix = false

highest = 0
while pointer < instructions.size
    instruction = instructions[pointer].split(" ")
    value = instruction[1].to_i
    inst = instruction[0]

    if !tried_to_fix && (inst == "jmp" || inst == "nop") && !fixed_pointers.add?(pointer).nil?
        # puts "fixing #{inst} at #{pointer}"
        if inst == "jmp"
            inst = "nop"
        else
            inst = "jmp"
        end
        tried_to_fix = true
        # puts "inst is now #{inst} #{value}"
    end

    case inst
    when "jmp"
        pointer += value
    when "acc"
        accumulator += value
        pointer += 1
    when "nop"
        pointer += 1
    end
    can_proceed = set.add?(pointer)
    if can_proceed.nil?
        # puts "can't proceed, restarting"
        accumulator = 0
        pointer = 0
        set = Set.new
        set.add(0)
        tried_to_fix = false
    end
end
puts accumulator