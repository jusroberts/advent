input = "35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576"

input = File.read("9.input")
numbers = input.split("\n").map {|a| a.to_i }

rolling_window = 25
target_num = 0

numbers.each_with_index do |number, index|
    if index < rolling_window
        next
    else
        found_sum = false
        (index-rolling_window..index-2).each do |i|
            (i..index-1).each do |j|
                found_sum = numbers[i] + numbers[j] == number
                # puts "#{numbers[i]} + #{numbers[j]} == #{number} => #{found_sum}"
                break if found_sum
            end
            break if found_sum
        end
        target_num = number if !found_sum
        break if !found_sum
    end

end

p target_num

numbers_size = numbers.size
testing_range = []

numbers.each_with_index do |number, index|

    testing_range = [number]
    sum = number

    (index+1..numbers_size-1).each do |i|
        testing_range << numbers[i]
        sum += numbers[i]
        break if sum >= target_num
    end
    if sum == target_num
        p "found it"

        testing_range.sort!
        p testing_range.inspect
        p testing_range[0] + testing_range[testing_range.size-1]
    end
end