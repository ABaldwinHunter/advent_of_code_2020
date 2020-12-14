input = File.read("input.txt").split("\n")

time = input.first.to_i

buses = input.last.split(",").reject { |bus| bus == 'x' }.map { |bus| bus.to_i }

answer =  nil

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
