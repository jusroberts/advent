input="L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL"


input = File.read "11.input"
seat_rows = input.split("\n").map {|a| a.split("")}

EMPTY = "L"
FLOOR = "."
OCCUPIED = "#"

def get_num_surrounding_occupied(row, column, seat_rows)
    count = 0
    count += 1 if get_spot_is_empty(row-1, column, seat_rows)
    count += 1 if get_spot_is_empty(row+1, column, seat_rows)
    count += 1 if get_spot_is_empty(row, column+1, seat_rows)
    count += 1 if get_spot_is_empty(row, column-1, seat_rows)
    count += 1 if get_spot_is_empty(row-1, column-1, seat_rows)
    count += 1 if get_spot_is_empty(row+1, column-1, seat_rows)
    count += 1 if get_spot_is_empty(row-1, column+1, seat_rows)
    count += 1 if get_spot_is_empty(row+1, column+1, seat_rows)
    count
end

def get_spot_is_empty(row, column, seat_rows)
    c_bounds = [0, seat_rows[0].size-1]
    r_bounds = [0, seat_rows.size-1]
    return false if row < r_bounds[0] || row > r_bounds[1]
    return false if column < c_bounds[0] || column > c_bounds[1]
    return seat_rows[row][column]# == "#"
end

def get_num_direction_occupied(row, column, seat_rows)
    count = 0
    count += 1 if crawl_in_direction(row, column, [0,1], seat_rows)
    count += 1 if crawl_in_direction(row, column, [0,-1], seat_rows)
    count += 1 if crawl_in_direction(row, column, [-1,1], seat_rows)
    count += 1 if crawl_in_direction(row, column, [-1,-1], seat_rows)
    count += 1 if crawl_in_direction(row, column, [1,1], seat_rows)
    count += 1 if crawl_in_direction(row, column, [1,-1], seat_rows)
    count += 1 if crawl_in_direction(row, column, [1,0], seat_rows)
    count += 1 if crawl_in_direction(row, column, [-1,0], seat_rows)
    count
end

def crawl_in_direction(row, column, vector, seat_rows)
    row += vector[0]
    column += vector[1]
    while (in_bounds(row, column, seat_rows))
        val = get_spot_is_empty(row, column, seat_rows)
        return true if val == "#"
        return false if val == "L"
        row += vector[0]
        column += vector[1]
    end
    return false
end

def in_bounds(row, column, seat_rows)
    c_bounds = [0, seat_rows[0].size-1]
    r_bounds = [0, seat_rows.size-1]
    return false if row < r_bounds[0] || row > r_bounds[1]
    return false if column < c_bounds[0] || column > c_bounds[1]
    true
end


seat_diff = 1000
while seat_diff > 0
    new_seats = []
    new_seats2 = []

    seat_diff = 0
    seat_rows.each do |row|
        new_seats << []
        new_seats2 << []
    end

    seat_rows.each_with_index do |row, i|
        row.each_with_index do |seat, j|
            # new_val = "."
            # if seat == EMPTY || seat == OCCUPIED
            #     count = get_num_surrounding_occupied(i, j, seat_rows)
            #     if seat == EMPTY && count == 0
            #         new_val = OCCUPIED
            #         seat_diff += 1
            #     elsif seat == OCCUPIED && count >= 4
            #         new_val = EMPTY
            #         seat_diff += 1
            #     else
            #         new_val = seat
            #     end
            # end
            # new_seats[i][j] = new_val


            new_val = "."
            if seat == EMPTY || seat == OCCUPIED
                count = get_num_direction_occupied(i, j, seat_rows)
                if seat == EMPTY && count == 0
                    new_val = OCCUPIED
                    seat_diff += 1
                elsif seat == OCCUPIED && count >= 5
                    new_val = EMPTY
                    seat_diff += 1
                else
                    new_val = seat
                end
            end
            new_seats2[i][j] = new_val
        end
    end
    
    # seat_rows.each {|a| p a.join}
    # puts "\n\n\n"
    seat_rows = new_seats2
end
seat_rows.each {|a| p a.join}
p seat_rows.flatten.count {|a| a == OCCUPIED}