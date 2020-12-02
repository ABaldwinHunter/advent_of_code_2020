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


# thirds
#

two_thirds = 673 * 2 # 1346

first_two_thirds = nums.select { |n| n <= two_thirds }
first_two_third_couples = {}

first_two_thirds.dup.each.with_index do |num, index|
  first_two_thirds.each.with_index do |n, i|
    if i != index
      key = [i, index].sort.map(&:to_s).join("_")

      if first_two_third_couples[key].nil?
        first_two_third_couples[key] = n + num
      end
    end
  end
end

rest = nums.select { |n| n > two_thirds }

nums.each.with_index do |num, index|
  first_two_third_couples.each do |key, sum|
    if (num + sum) == target
      indices = key.split("_").map(&:to_i)

      unless indices.include? index
        puts "Found three: #{num}, #{nums[indices.first]}, #{nums[indices.last]}"
        puts "product is #{(num * nums[indices.first] * nums[indices.last])}"
      end
    end
  end
end

# Found three: 1406, 277, 337
# product is 131248694
