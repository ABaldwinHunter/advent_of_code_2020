# bags  galore
# 1 shiny gold bag
#

FILE = "input.txt"
# FILE = "sample.txt"

BAG_MAP = begin
            map = {}

            rules = File.read(FILE).split("\n")

            rules.each do |rule|
              type = rule.split(" bags contain ").first

              contents = rule.split(" bags contain ").last

              content_types = (contents.split /\d+ /).map { |item| item.split(" bag").first }.compact

              map[type] = content_types
            end
            map
          end

# Part I


BAG_TYPES = BAG_MAP.keys
BAG_CONTENTS = BAG_MAP.values.flatten.uniq

OUTERMOST_NODES = BAG_TYPES.select { |type| !BAG_CONTENTS.include? type }
LEAF_NODES = BAG_TYPES.select { |type| !BAG_TYPES.include?(type) || BAG_MAP[type] == ["no other"] }

def contains_gold?(type:)
  if BAG_MAP[type].include? 'shiny gold'
    true
  elsif LEAF_NODES.include?(type)
    false
  else
    BAG_MAP[type].any? { |type| contains_gold?(type: type) }
  end
end

nodes = BAG_TYPES.select { |node| contains_gold?(type: node) }

puts "Answer is #{nodes.count}"

# Part II
#
#

BAG_MAP_2 = begin
              map = {}

              rules = File.read(FILE).split("\n")

              rules.each do |rule|
                type = rule.split(" bags contain ").first

                contents = rule.split(" bags contain ").last

                content_types = (contents.split /\d+ /).map { |item| item.split(" bag").first }.compact

                with_nums = []

                content_types.each do |t|
                  quant = contents.split(t).first.to_i

                  with_nums << [quant, t]
                end

                map[type] = with_nums
              end
              map
            end

def count_children(color:, so_far: 0)
  puts "color is #{color}"
  # puts "so far is #{so_far}"
  if color == "no other"
    so_far
  else
    BAG_MAP_2[color].each do |arry_content|
      so_far += arry_content.first
    end

    old_so_far = so_far

    BAG_MAP_2[color].each do |arry_content|
      num = arry_content.first
      col = arry_content.last

      so_far += num * count_children(color: col, so_far: old_so_far)
    end

    so_far
  end
end

puts count_children(color: "shiny gold")
