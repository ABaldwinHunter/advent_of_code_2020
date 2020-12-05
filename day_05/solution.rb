
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

seats = File.read("input.txt").split("\n")
 puts seats.map { |s| Seat.new(s).id }.max

