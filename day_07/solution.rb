# bags  galore
# 1 shiny gold bag
#

FILE = "input.txt"
# # FILE = "sample.txt"
# FILE = "sample_two.txt"

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

puts "Part I answer is #{nodes.count}"

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

                content_types.each.with_index do |t, indx|
                  parts = contents.split(",")

                  quant = parts[indx].split(t).first.to_i

                  with_nums << [quant, t]
                end

                map[type] = with_nums
              end
              map
            end

# for each bag we want its own children, plus their children

def count_children(color:)
  if color == "no other"
    0
  else
    children_counts = BAG_MAP_2[color].map { |content_arry| content_arry.first }
    children = children_counts.inject(0) { |sum,x| sum + x }

    ary = BAG_MAP_2[color]

    ary.each do |arry_content|
      num = arry_content.first
      col = arry_content.last

      children += num * count_children(color: col)
    end

    children
  end
end

puts "Part II answer is #{count_children(color: "shiny gold")}"
