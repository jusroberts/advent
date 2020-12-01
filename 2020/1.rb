input = File.read("1.input")



target = 2020


vals = input.split.map {|a| a.to_i }

vals.each_with_index do |val, index|
    goal1 = target - val
    (index..vals.size-2).each do |j|
        if vals[j] == goal1
            p "1: #{val * vals[j]}"
        end
        goal2 = goal1 - vals[j]
        if goal2 > 0
            (j..vals.size-3).each do |k|
                if vals[k] == goal2
                    p "2: #{val * vals[j] * vals[k]}"
                end
            end
        end
    end
end