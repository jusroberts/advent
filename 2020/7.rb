input = "light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags."

input = File.read("7.input")
# input = "shiny gold bags contain 2 dark red bags.
# dark red bags contain 2 dark orange bags.
# dark orange bags contain 2 dark yellow bags.
# dark yellow bags contain 2 dark green bags.
# dark green bags contain 2 dark blue bags.
# dark blue bags contain 2 dark violet bags.
# dark violet bags contain no other bags."
rules = input.split("\n")

@objective = "shiny gold"

#parse bags
@bag_types = {}

class Bag 
    attr_accessor :type, :holds, :contains_objective
    def initialize(type, holds)
        @type = type
        @holds = holds 
        @contains_objective = 0
        @contains_objective = 1 if type == "shiny gold"
        @contains_objective = -1 if holds == nil
    end

end

rules.each do |rule|
    first = rule.split(" bags contain ")
    type = first[0]
    holds = nil
    if first[1]!= "no other bags."
        holds = first[1].split(", ").map do |a| 
            val = a.gsub(/\s(bags\.|bag\.|bags|bag)/, "")
            number = val[/[0-9]+\s/].strip.to_i
            size = val[/[0-9]+\s/].size
            sub_type = val[size..val.size-size+1]
            [number, sub_type]
        end
    end
    @bag_types[type] = Bag.new(type, holds)
end

#type => [[1, bag_type1], [5, bag_type2]]
#type => nil

def can_hold_shiny_gold_bag(type)
    return true if type.type == @objective
    return false if type.holds == nil
    type.holds.each do |hold_bag|
        bag = @bag_types[hold_bag[1]]
        if can_hold_shiny_gold_bag(bag)
            return true
        end
    end
    return false
end

count = 0

@bag_types.each do |key, value|
    next if key == @objective
    if can_hold_shiny_gold_bag(value)
        count += 1 
    end

    puts key if !value.holds.nil? && value.holds.include?(@objective)
end

p count

bag = @bag_types[@objective]
count = 0

def bag_count(bag)
    count = 1
    if bag.holds == nil
        return 1
    end
    bag.holds.each do |raw_bag|
        num_bags = raw_bag[0]
        this_bag_holds = bag_count(@bag_types[raw_bag[1]])
        puts "#{bag.type} holds #{num_bags} #{raw_bag[1]} which holds #{this_bag_holds}"
        count += num_bags * this_bag_holds
    end

    return count
end

# 2178 is too low
p bag_count(bag) - 1