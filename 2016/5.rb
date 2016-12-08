require 'digest'

input = "wtnhxymk"
# input = "abc"

password = []

acceptance_string = "00000"
iteration = 0
# while(password.length < 8) do
#   test_string = Digest::MD5.hexdigest "#{input}#{iteration}"
#   if test_string[0..4] == acceptance_string
#     password << test_string[5]
#   end
#   iteration += 1
# end

password_complete = 0
while(password_complete < 8) do
  test_string = Digest::MD5.hexdigest "#{input}#{iteration}"
  if test_string[0..4] == acceptance_string
    if test_string[5].to_i <= 7 && test_string[5].to_i > 0
      if password[test_string[5].to_i] == nil
        password[test_string[5].to_i] = "#{test_string[6]}"
        password_complete += 1
        puts iteration
        puts test_string
        puts "#{test_string[5].to_i} - #{test_string[6]}"
      end
    elsif test_string[5] == "0"
      if password[0] == nil
        password[0] = test_string[6]
        puts "0 - #{test_string[6]}"
        password_complete += 1
      end
    end
  end
  iteration += 1
end
puts password.join