input="ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in"
input = "hcl:#ae17e1
iyr:2013
eyr:2024
ecl:brn
pid:760753108
byr:1931
hgt:179cm"
input = File.read("4.input")

input = input.split("\n\n")

required_fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]#, "cid"]

num_valid = 0

input.each do |passport|
    valid = true
    required_fields.each do |field|
        valid = passport.include?(field)
        break if !valid
    end
    num_valid += 1 if valid
end

p num_valid

eye_colors = "amb blu brn gry grn hzl oth".split


num_valid = 0

input.each do |passport|
    valid = true
    required_fields.each do |field|
        valid = passport.include?(field)
        break if !valid
        
    end
    if valid
        passport_fields = passport.split
        passport_fields.each do |field|
            type = field.split(":")[0]
            value = field.split(":")[1]
            valid = case type
            when "byr"
                value.to_i >= 1920 && value.to_i<= 2002
            when "iyr"
                value.to_i >=2010 && value.to_i <= 2020
            when "eyr"
                value.to_i >= 2020 && value.to_i <= 2030
            when "hgt"
                cm = value.include?("cm") ? value.to_i : 0
                inches = value.include?("in") ? value.to_i : 0
                (cm >= 150 && cm <= 193) || (inches >= 59 && inches <= 76)
            when "hcl"
                p field
                value.match(/#[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]/)
            when "ecl"
                eye_colors.include? value
            when "pid"
                value.match(/^[0-9]*/) && value.size == 9
            end
            # p "failed on #{field}" if valid == false && field.include?("pid")
            break if valid == false
        end
    end
    num_valid += 1 if valid
end

p num_valid