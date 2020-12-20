# parse tiles
# identify borders
# think about how to performantly arrange
#

class Tile
  attr_reader :id, :body

  attr_accessor :north_edge, :south_edge, :east_edge, :west_edge

  def initialize(id:, body:)
    @id = id
    @body = body
  end

  def matches_any_edge?(other)
    other_edges = [other.north_edge, other.south_edge, other.east_edge, other.west_edge]

    [north_edge, south_edge, east_edge, west_edge].any? do |edge|
      other_edges.include?(edge) || other_edges.include?(edge.reverse)
    end
  end

  def north_edge
    @north_edge ||= starting_north_edge
  end

  def south_edge
    @south_edge ||= starting_south_edge
  end

  def east_edge
    @east_edge ||= starting_east_edge
  end

  def west_edge
    @starting_west_edge ||= starting_west_edge
  end

  def starting_north_edge
    body.first
  end

  def starting_south_edge
    body.last
  end

  def starting_east_edge
    @starting_east_edge ||= body.map { |row| row.last }
  end

  def starting_west_edge
    @starting_west_edge ||= body.map { |row| row.first }
  end

  # [
  #   [2,1,3]
  #   [2,3,4]
  #   [1,2,5]
  # ]

  # def rotate_right!
  #   old_north = north_edge
  #   old_south = south_edge
  #   old_east = east_edge
  #   old_west = west_edge

  #   east_edge = old_north
  #   south_edge = old_east
  #   west_edge = old_south
  #   north_edge = old_west
  # end

  # def rotate_left!
  #   old_north = north_edge
  #   old_south = south_edge
  #   old_east = east_edge
  #   old_west = west_edge

  #   east_edge = old_south
  #   south_edge = old_west
  #   west_edge = old_north
  #   north_edge = old_east
  # end

  # def rotate_180!
  #   old_north = north_edge
  #   old_south = south_edge
  #   old_east = east_edge
  #   old_west = west_edge

  #   east_edge = old_west
  #   south_edge = old_north
  #   west_edge = old_east
  #   north_edge = old_south
  # end
end

# board is 3 X 3
#
FILE = "tiles.txt"
# FILE = "sample.txt"

split_tiles = File.read(FILE).split /\n{2,}/

puts "split tiles are: "
p split_tiles

tiles = split_tiles.map do |tile_str|
  puts "string is: "
  p tile_str

  lines = tile_str.split("\n")

  puts "lines"

  p lines

  id_line = lines.shift

  puts "id line"

  p id_line

  id = id_line.split("Tile ").last.split(":").first.to_i

  Tile.new(id: id, body: lines.map { |row| row.split("") })
end

puts "tiles are: "

p tiles

# approach 1
# first, make a list or data structure of all the matching edges
# the corner tiles will be the only ones that only have two matching edges with other tiles
#

matches = {} # tile_id => [matching tiles]

tiles.each do |tile|
  tile_matches = []
  # require 'pry'; binding.pry

  # not the most performant. n2 here i think
  tiles.each do |t|
    if (t.id != tile.id) && tile.matches_any_edge?(t)
      tile_matches << t.id
    end
  end

  matches[tile.id] = tile_matches
end

puts "matches are: "
p matches

corners = matches.select do |tile_id, matches|
  matches.uniq.count == 2
end.keys

puts "corners"
p corners

puts "corner_ids are #{corners}"

answer = corners.inject(:*)

# Part I
puts "Answer is #{answer}"

# Part II
#
#
area = tiles.length
square_side = Math.sqrt(area)

board = []

tiles.each_slice(3) do |a|
  board << a
end


