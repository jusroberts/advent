input = "28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3"
input = File.read("10.input")
class JoltAdapter 
    attr_accessor :num
    def initialize(num)
        @num = num
    end

    def can_interface(num)
        @num-num if num < @num && num >= @num-3
    end
end


jolt_adapters = input.split("\n").map {|a| JoltAdapter.new(a.to_i)}

current_jolts = 0
jolt_differences = {}
(1..3).each do |i|
    jolt_differences[i] = 0
end
jolt_differences[3] = 1

while !jolt_adapters.empty?
    cont = false
    (1..3).each do |i|
        jolt_adapters.each_with_index do |adapter, index|
            difference = adapter.can_interface(current_jolts)
            if difference == i
                jolt_adapters.delete_at(index)
                p "#{current_jolts} to #{adapter.num} = #{difference}"
                jolt_differences[difference] += 1
                current_jolts = adapter.num
                cont = true
                break
            end
        end
        break if cont
    end
    break unless cont
end

puts "final rating #{current_jolts}"
puts jolt_adapters.inspect
p jolt_differences.inspect
p jolt_differences[1] * jolt_differences[3]