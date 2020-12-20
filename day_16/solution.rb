FILE = 'input.txt'

sections = File.read(FILE).split(/\n{2,}/)

rules = sections.first

my_ticket = sections[1]

nearby_ticket_section = sections[2]

nearby_tickets = nearby_ticket_section.split("\n")
nearby_tickets.shift # get rid of "nearby tickets:"

arrays_of_nums = nearby_tickets.map { |str| str.split(",").map { |num| num.to_i } }

all_nums = arrays_of_nums.flatten

num_hash = {}

# track occurrences
all_nums.sort.each do |num|
  if num_hash[num]
    num_hash[num] = num_hash[num] + 1
  else
    num_hash[num] = 1
  end
end

range_pairs = rules.split("\n").map { |rule| rule.split(": ").last }

unparsed_ranges = range_pairs.map { |pair| pair.split(" or ") }.flatten

ranges = unparsed_ranges.map { |range| range.split("-").map { |num| num.to_i } }

range_simplifier = {}

ranges.each do |tuple|
  bottom = tuple.first
  top = tuple.last

  if range_simplifier[bottom] && range_simplifier[bottom] < range_simplifier[bottom]
    range_simplifier[bottom] = top
  elsif range_simplifier[bottom].nil?
    range_simplifier[bottom] = top
  end
end

simplified = []

range_simplifier.each do |bottom, top|
  simplified << [bottom, top]
end

odd_duck_count = 0

num_hash.each do |key, occurrences|
  if simplified.none? { |tuple| key >= tuple.first && key <= tuple.last }
    errors = key * occurrences
    odd_duck_count += errors
  end
end

puts "odd duck count is #{odd_duck_count}"

# Part II

invalid_numbers = []

num_hash.each do |key, occurrences|
  if simplified.none? { |tuple| key >= tuple.first && key <= tuple.last }
    invalid_numbers << key
  end
end

rules = sections.first

my_ticket = sections[1]

nearby_tickets = nearby_ticket_section.split("\n")
nearby_tickets.shift # get rid of "nearby tickets:"

arrays_of_nums = nearby_tickets.map { |str| str.split(",").map { |num| num.to_i } }
valid_tickets = arrays_of_nums.reject { |ticket| ticket.any? { |num| invalid_numbers.include?(num) } }

puts "valid ticket count is #{valid_tickets.count}"

rules_hash = {}

rules.split("\n").map do |str|
  parts = str.split(": ")
  field = parts.first

  ranges_part = parts.last

  unparsed_ranges = ranges_part.split(" or ")

  ranges = unparsed_ranges.map { |range| range.split("-").map { |num| num.to_i } }

  rules_hash[field] = ranges
end
