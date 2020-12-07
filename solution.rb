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
