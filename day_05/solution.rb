
# 128 rowws on plane numbered 0-127
# 8 cols on  plane 0-7
#

class Seat
  def initialize(raw_seat)
    @raw_seat = raw_seat
  end

  def id
    row * 8 + column
  end

  def row
    @row ||= recursive_search(directions: row_directions, bounds: [0, 127], lower: 'F')
  end

  def column
    @column ||= recursive_search(directions: col_directions, bounds: [0, 7], lower: 'L')
  end

  private

  attr_reader :raw_seat

  def row_directions
    raw_seat[0..6].split ""
  end

  def col_directions
    raw_seat[7..9].split ""
  end

  def recursive_search(directions:, bounds:, lower:)
    if (bounds.last - bounds.first) == 1
      if directions.first == lower
        bounds.first
      else
        bounds.last
      end
    else
      direction = directions.shift
      mid = bounds.first + (bounds.last - bounds.first) / 2

      new_bounds = if direction == lower
                     [bounds.first, mid]
                   else
                     [mid, bounds.last]
                   end

      recursive_search(directions: directions, bounds: new_bounds, lower: lower)
    end
  end
end

# part I
#
seats = File.read("input.txt").split("\n").map { |s| Seat.new(s) }

puts seats.map(&:id).max

# part II
#
#

# sorted = seats.sort_by { |s| "#{s.row} #{s.column}" }

# sorted.each do |seat|
#   p "row #{seat.row} col #{seat.column}"
# end

plane = {}

(0..127).each do |num|
  plane[num] = []
end

seats.each do |seat|
  plane[seat.row] << seat
end

rows_missing_seats = plane.select { |row, seats| seats.length < 8 && seats.length > 0 }.values

missing_seat_ids = []

rows_missing_seats.each do |row|
  row_num = row.first.row
  cols_present = row.map { |seat| seat.column }

  missing_cols = (0..7).select { |num| cols_present.none? num }

  missing_cols.each { |col| missing_seat_ids << (8 * row_num + col) }
end

all_ids = seats.map(&:id)

my_seat_id = missing_seat_ids.select { |id| all_ids.include?(id - 1) && all_ids.include?(id + 1) }

puts "my seat id: #{my_seat_id}"
