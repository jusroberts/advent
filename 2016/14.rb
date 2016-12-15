require 'digest'
require 'pry-byebug'

salt = "abc"
salt = "ahsbgdzn"

def check_hash(hash, iteration)
  (0..hash.length - 4).each do |i|
    char = hash[i]
    if hash[i, 3] == "#{char}#{char}#{char}"
      begin
        if hash[i, 4] != "#{char}#{char}#{char}#{char}"
          # binding.pry if iteration == 110
          return {iteration: iteration, char: char}
        end
      rescue => e 
        binding.pry
        a = "asdf"
      end
    end
  end
  return false
end

def hash_n_times(salt, iteration, times)
  hash = Digest::MD5.hexdigest("#{salt}#{iteration}").downcase
  (0..times - 1).each do |i|
    hash = Digest::MD5.hexdigest(hash).downcase
  end
  hash
end

iteration = 0

possible_hits = []
positive_hits = []

while positive_hits.length < 65
  test_hash = hash_n_times(salt, iteration, 2016)
  a = check_hash(test_hash, iteration)
  possible_hits << a if a

  remove_from_possible = []
  (0..test_hash.length - 6).each do |i|
    possible_hits.each_with_index do |p, index|
      next if p[:iteration] == iteration
      char = p[:char]
      if test_hash[i, 5] == "#{char}#{char}#{char}#{char}#{char}"
        positive_hits << p
        remove_from_possible << index
      end
    end
  end
  # binding.pry if iteration == 18
  remove_from_possible.each do |r|
    possible_hits.delete_at(r)
  end
  iteration += 1
  possible_hits.select! do |p|
    p[:iteration] > iteration - 1000
  end
end
positive_hits.sort! {|a, b| a[:iteration] <=> b[:iteration]}
binding.pry
puts positive_hits[62][:iteration]
puts positive_hits[63][:iteration]
puts positive_hits[64][:iteration]