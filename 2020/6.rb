require "set"

input = "abc

a
b
c

ab
ac

a
a
a
a

b"
input = File.read("6.input")

groups = input.split("\n\n")

yes_count = 0

groups.each do |group|
    set = Set[]
    group.each_char do |char|
        set.add(char) if char != "\n" 
    end
    yes_count += set.size
end

puts yes_count

yes_count = 0
groups.each do |group|
    group_set = Set[]
    group.split("\n").each_with_index do |answers, index|
        person_set = Set[]
        answers.each_char do |answer|
            if index == 0
                group_set.add(answer) 
            end
            person_set.add(answer)
        end
        group_set = group_set & person_set
    end
    yes_count += group_set.size
end

puts yes_count