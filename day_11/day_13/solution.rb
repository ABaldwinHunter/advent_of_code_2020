input = File.read("input.txt").split("\n")

time = input.first.to_i

buses = input.last.split(",").reject { |bus| bus == 'x' }.map { |bus| bus.to_i }

answer = nil

i = 0

while answer.nil?
  later_time = time + i

  buses.each do |bus|
    if (later_time % bus) == 0
      answer = bus * (later_time - time)
    end
  end

  i += 1
end

puts "answer is #{answer}"

# part II

inputs = "17,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,643,x,x,x,x,x,x,x,23,x,x,x,x,13,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,29,x,433,x,x,x,x,x,37,x,x,x,x,x,x,x,x,x,x,x,x,19".split(",").map do |item|
  if item == "x"
    item
  else
    item.to_i
  end
end

# num % 17 = 0
# (num + 7) % 41 = 0
# 41 - 7 = 34

# number should be divisible by 34, and 17
#
factors = []

inputs.each.with_index do |item, index|
  if item == "x"
    next
  else
    factors << (item)
    factors << (item + index)
  end
end

answer = factors.inject(1) { |product,x| x * product }
puts "answer is #{answer}"
