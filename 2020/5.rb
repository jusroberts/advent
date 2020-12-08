input="BFFFBBFRRR
FFFBBBFRRR
BBFFBBFRLL"

input = File.read("5.input")
input = input.split()

rows = 128
columns = 8
max_id = 0
seats = {}
(0..128 * 8).each do |i|
    seats[i] = "EMPTY"
end
input.each do |location|
    start_row = 0
    start_col = 0
    remaining_rows = rows
    remaining_columns = columns
    (0..6).each do |i|
        remaining_rows /= 2
        if location[i] == "F"
            start_row = start_row
        else
            start_row += remaining_rows
        end
    end
    (7..9).each do |i|
        remaining_columns /= 2
        if location[i] == "R"
            start_col += remaining_columns
        else

        end
    end
    id = start_row * columns + start_col
    max_id = max_id > id ? max_id : id
    seats[id] = "t"
    # puts "#{location}: #{start_row} #{start_col} #{id}"
end

puts max_id

puts seats.inspect