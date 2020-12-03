rows = File.read("./input.txt").split("\n")

items = rows.map { |row| row.split(" ") }.map do |item|
  item[0] = item[0].split("-").map(&:to_i) # range
  item[1] = item[1].split(":").first
  item[2] = item[2]
  item
end

## Part 1
# def valid?(range, letter, password)
#   occurrences = password.count(letter)

#   if (occurrences >= range.first and occurrences <= range.last)
#     true
#   else
#     false
#   end
# end

## Part 2
#

def valid?(indices, letter, password)
  a = (password[(indices.first - 1)] == letter)
  b = (password[(indices.last - 1)] == letter)

  (a || b) && !(a && b)
end

valid_count = 0

items.each do |item|
  if valid?(item[0], item[1], item[2])
    valid_count += 1
  end
end

puts "Valid count is #{valid_count}"
