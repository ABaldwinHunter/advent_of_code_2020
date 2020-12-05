# byr (Birth Year)
# iyr (Issue Year)
# eyr (Expiration Year)
# hgt (Height)
# hcl (Hair Color)
# ecl (Eye Color)
# pid (Passport ID)
# cid (Country ID)

required_fields = %w(
  byr
  iyr
  eyr
  hgt
  hcl
  ecl
  pid
)

optional = 'cid'

input = File.read("./input.txt")

passports = input.split(/\n{2,}/) # blank line

valid_count = 0

# Part I
#
# passports.each do |str|
#   items = str.split(':').map { |item| item.split(" ").last }
#   if required_fields.all? { |field| items.include?(field) }
#     valid_count += 1
#   end
# end

# puts "valid count is #{valid_count}"

# part II
#

def valid?(key, value)
  case key
  when 'byr'
    value.to_i >= 1920 && value.to_i <= 2002
  when 'iyr'
    value.to_i >= 2010 && value.to_i <= 2020
  when 'eyr'
    value.to_i >= 2020 && value.to_i <= 2030
  when 'hgt'
    items = value.split(/(\d+)/)
    items.shift
    return false unless (items.count == 2 && ["cm", "in"].include?(items.last))

    if items.last == 'in'
      items.first.to_i >= 59 && items.first.to_i <= 76
    elsif items.last == 'cm'
      items.first.to_i >= 150 && items.first.to_i <= 193
    end
  when 'hcl'
    parts = value.split("#")

    value[0] == "#" &&
    parts.last.length == 6
    parts.last.split("").all? { |ch| "abcdef0123456789".include? ch }
  when 'ecl'
    %w(amb blu brn gry grn hzl oth).include? value
  when 'pid'
    value.length == 9 && value.to_i != 0
  when 'cid'
    true
  else
    false
  end
end

passports.each do |str|
  items = str.split /[\n ]+/

  # next unless required_fields.all? { |field| items.map { |str| str.split(":").first }.include? field }
  #
  keys = items.map { |i| i.split(":").first }

  next unless required_fields.all? { |i| keys.include? i }

  valid = items.all? do |item|
    key = item.split(":").first;
    value = item.split(":").last;
    good = valid?(key, value)

    if good
      puts "valid. #{key}:#{value}"
    else
      puts "invalid:#{key}:#{value}"
    end
    good
  end

  if valid
    valid_count += 1
  end
end

puts "valid count is #{valid_count}"
