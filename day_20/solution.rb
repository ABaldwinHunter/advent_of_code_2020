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

  def matches_edge?(edge)
    [north_edge, south_edge, east_edge, west_edge].any? do |e|
      e == edge || e.reverse == edge
    end
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

  def rotate_right!
    old_north = north_edge
    old_south = south_edge
    old_east = east_edge
    old_west = west_edge

    east_edge = old_north
    south_edge = old_east
    west_edge = old_south
    north_edge = old_west
  end

  def rotate_left!
    old_north = north_edge
    old_south = south_edge
    old_east = east_edge
    old_west = west_edge

    east_edge = old_south
    south_edge = old_west
    west_edge = old_north
    north_edge = old_east
  end

  def rotate_180!
    old_north = north_edge
    old_south = south_edge
    old_east = east_edge
    old_west = west_edge

    east_edge = old_west
    south_edge = old_north
    west_edge = old_east
    north_edge = old_south
  end
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

  id_line = lines.shift

  id = id_line.split("Tile ").last.split(":").first.to_i

  Tile.new(id: id, body: lines.map { |row| row.split("") })
end

matches = {} # tile_id => [matching tiles]

tiles.each do |tile|
  tile_matches = []

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

corner_ids = matches.select do |tile_id, matches|
  matches.uniq.count == 2
end.keys

edge_piece_ids = matches.select do |title_id, matches|
  matches.uniq.count == 3
end.keys

# Part II
#
# actually orient whole board
# remve tile boarders
# then find the sea monsters
#
area = tiles.length
square_side = Math.sqrt(area)

board = []

tiles.each_slice(square_side) do |a|
  board << a
end

# build the edges, then the inside
#

puzzle_booard = []

square_side.times do
  table_top << []
end

corners = tiles.select { |tile| corner_ids.include? tile.id }
edge_pieces = tiles.select { |tile| edge_piece_ids.include? tile.id }
middle_pieces = tiles.reject { |tile| corner_ids.include?(tile.id) || edge_piece_ids.include?(title.id) }

first_corner = corners.first

# make sure north and west sides don't match any other sides
#

outer_edges = []

north_is_outer = tiles.none? { |t| t.matches_edge?(first_corner.north) }
west_is_outer = tiles.none? { |t| t.matches_edge?(first_corner.north) }

while !(north_is_outer && west_is_outer)
  first_corner.rotate_left!

  north_is_outer = tiles.none? { |t| t.matches_edge?(first_corner.north) }
  west_is_outer = tiles.none? { |t| t.matches_edge?(first_corner.north) }
end

puzzle_board.first << corners.first # should be oriented

while puzzle_board.first.length < square_side # fill first row
  (edge_pieces + corners).each do |tile|
    latest = puzzle_board.first.last

    if tile.matches_edge?(latest.east_edge) && tile.id != latest.id
      puzzle_board.first << tile
    end
  end
end


