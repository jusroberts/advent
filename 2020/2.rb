input = File.read("2.input").split("\n")
# input = "1-3 a: abcde
# 1-3 b: cdefg
# 2-9 c: ccccccccc".split("\n")

class Password
    attr_accessor :range, :letter, :pw

    def initialize(line)
        @range = line.split[0].split("-").map {|a| a.to_i }
        @letter = line.split[1][0]
        @pw = line.split[2]
    end

    def is_valid?
        count_of_letter = 0
        @pw.each_char do |letter|
            count_of_letter += 1 if letter == @letter
        end
        count_of_letter >= @range[0] && count_of_letter <= @range[1]
    end

    def is_valid2?
        value = (@pw[@range[0]-1] == @letter) ^ (@pw[@range[1]-1] == @letter)
        p "#{@letter} - #{@pw} - 1: #{@pw[@range[0]]} - 2: #{@pw[@range[1]]} --- #{value}"
        value
    end
end

count = 0
count2 = 0
input.each do |line|
    pw = Password.new(line)
    count += 1 if pw.is_valid?
    count2 += 1 if pw.is_valid2?
end

p count
p count2
