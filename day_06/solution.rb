input = File.read("./input.txt")

groups = input.split(/\n{2,}/) # blank line

# Part I
counts = groups.map do |group|
  group.split("\n").join("").split("").uniq.count
end

# Part II
#

counts = groups.map do |group|
  individuals = group.split("\n").map { |str| str.split("") }

  nay_sayer = individuals.min { |answers| answers.length }

  yes_count = 0

  nay_sayer.each do |letter|
    if individuals.all? { |i| i.include? letter }
      yes_count += 1
    end
  end

  yes_count
end

sum = 0

counts.each do |count|
  sum += count
end

puts "sum is #{sum}"

