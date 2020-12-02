nums = File.read("./input.txt").split("\n").map(&:to_i).reject { |n| n > 2020 }.sort

target = 2020

half = 1010

less_than_or_equal_half = nums.select { |n| n <= half }
greater_than_half = nums.select { |n| n > half }

last_index = greater_than_half.length - 1

less_than_or_equal_half.each do |n|
  # TODO: binary search for match
  # sum = n + greater_than_half[last_index]
  greater_than_half.each do |big_n|
    if n + big_n == 2020
      puts "Found them! #{n} and #{big_n}"
      puts "product is #{(n * big_n)}"
    end
  end
end

# Found them! 861 and 1159
# product is 997899

first_third = nums.select { |n| n <= 700 }

nums.each.with_index do |num, index|
end

