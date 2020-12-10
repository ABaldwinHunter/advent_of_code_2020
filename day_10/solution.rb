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
