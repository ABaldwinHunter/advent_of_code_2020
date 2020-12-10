FILE_NAME = 'input.txt'
# FILE_NAME = 'sample.txt'
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

# (0), 1, 4, 5, 6, 7, 10, 11, 12, 15, 16, 19, (22)
# (0), 1, 4, 5, 6, 7, 10, 12, 15, 16, 19, (22)
# (0), 1, 4, 5, 7, 10, 11, 12, 15, 16, 19, (22)
# (0), 1, 4, 5, 7, 10, 12, 15, 16, 19, (22)
# (0), 1, 4, 6, 7, 10, 11, 12, 15, 16, 19, (22)
# (0), 1, 4, 6, 7, 10, 12, 15, 16, 19, (22)
# (0), 1, 4, 7, 10, 11, 12, 15, 16, 19, (22)
# (0), 1, 4, 7, 10, 12, 15, 16, 19, (22)

fixed_segments = []
dynamic_segments  = []

# array.combination
#
# multiply the number of possibilities in the dynamic sections

current_segment = []
segment_start = 0 # include start and end of previous segment
latest_segment_adapter = 0

sorted.each.with_index do |adapter, index|
  diff = adapter - latest_segment_adapter
  if diff <= 3 # continue segment

end
