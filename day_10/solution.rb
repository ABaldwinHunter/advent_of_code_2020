# FILE_NAME = 'input.txt'
FILE_NAME = 'sample.txt'
# FILE_NAME = 'larger_sample.txt'

adapters = File.read(FILE_NAME).split("\n").map(&:to_i)

sorted = adapters.sort

extra = sorted.last + 3

sorted << extra

one_jolt_differences = 0
three_jolt_differences = 0

last_adapter = 0;

sorted.each do |adapter|
  diff = adapter - last_adapter

  if diff == 1
    one_jolt_differences += 1
  elsif diff == 3
    three_jolt_differences += 1
  end

  last_adapter = adapter
end

puts "One jolt differences = #{one_jolt_differences}. Three jolt: #{three_jolt_differences}. Product: #{(one_jolt_differences * three_jolt_differences)}"

# Part II combinatorics
#
# Whenever there is one that can be switched out it is like an extra input to a combinatorics
#
# the answer seems related to the three and  one jolt jumps

# array.combination
#
# multiply the number of possibilities in the dynamic sections

three_jolt_markers = []

last_adapter = 0;

sorted.each.with_index do |adapter, index|
  diff = adapter - last_adapter

  if diff == 3
    three_jolt_markers << index
  end

  last_adapter = adapter
end

last = 0
changeables = []

three_jolt_markers.each do |index|
  distance = index - last

  if distance > 1
    start = last + 1
    stop = index - 1

    changeables << sorted[(start.to_i)..(stop.to_i)]
    last = index
  else
    last = index
    next
  end
end

puts "changeables are:"

p changeables

# calculate possibilities for each changable section
#

without_too_many_blanks = changeables.map do |changeable_section|
  length = changeable_section.length

  length.times do |_i|
    changeable_section << "blank"
  end

  combos = changeable_section.combination(length).to_a

  puts "combos:"
  p combos

  combos.reject do |combo|
    # can't have more than three blanks in a row
    combo.map(&:to_s).sort.join("").include?("blankblankblank") || combo.uniq.all? { |item| item == "blank" }
  end
end

puts "pruned:"
p without_too_many_blanks

unique_options = without_too_many_blanks.map { |ary| ary.uniq }

puts "unique options:"

p unique_options

possibilities = unique_options.map(&:count)

puts "Calculating"

puts "possibilities: #{possibilities}"

answer = possibilities.inject(:*)

puts "answer is #{answer}"
