# bags  galore
# 1 shiny gold bag
#
rules = File.read("input.txt").split("\n")

class Bag
  attr_accessor :type

  def initialize(type:)
    @type = type
  end

  def children
  end
end

bag_map = {}

rules.each do |rule|
  type = rule.split(" bags contain ").first

  contents = rule.split(" bags contain ").last

  content_types = (contents.split /\d+/).map { |item| item.split("bag").first }

  bag_map[type] = content_types
end

# Part I
# find shiny gold bag owners
#
# shiny_gold_bag_owners = []

# bag_map.each do |type, bags|
#   if bags.include? "shiny gold"
#     shiny_gold_bag_owners << type
#   end
# end

# outermost_parents = []

# def find_outermost_bag(child_type:, outermost_bags: [])
#   new_parents = []

#   bag_map.each do |type, contents|
#     if contents.include? child_type
#       new_parents << type
#     end
#   end

#   if new_parents.none?
#     outermost_bags << child_type

#     outermost_bags
#   else
#     new_parents.each do |new_type|
#       outermost_bags << find_outermost_bag(child_type: new_type, outermost_bags: outermost_bags)
#     end
#   end
# end

# find_outermost_bag(child_type: "shiny gold", outermost_bags: [])
