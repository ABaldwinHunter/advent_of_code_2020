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
    body.first
  end

  def south_edge
    body.last
  end

  def east_edge
    @east_edge ||= body.map { |row| row.last }
  end

  def west_edge
    @west_edge ||= body.map { |row| row.first }
  end
end

FILE = "tiles.txt"
# FILE = "sample.txt"

split_tiles = File.read(FILE).split /\n{2,}/

tiles = split_tiles.map do |tile_str|
  lines = tile_str.split("\n")

  id_line = lines.shift

  id = id_line.split("Tile ").last.split(":").first.to_i

  Tile.new(id: id, body: lines.map { |row| row.split("") })
end

# approach 1
# first, make a list or data structure of all the matching edges
# the corner tiles will be the only ones that only have two matching edges with other tiles
#

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

corners = matches.select do |tile_id, matches|
  matches.uniq.count == 2
end.keys

puts "corner_ids are #{corners}"

answer = corners.inject(:*)

# Part I
puts "Answer is #{answer}"
