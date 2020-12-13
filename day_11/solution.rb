OCCUPIED = "#"
FLOOR = "."
EMPTY = "L"

rows = File.read("input.txt").split("\n").map! { |row| row.split("") } # array of arrays


# class Spot
#   OCCUPIED = "#"
#   FLOOR = "."
#   EMPTY = "L"

#   attr_accessor :x, :y, :contents

#   def occupied?
#     contents == EMPTY
#   end

#   def floor?
#     contents == FLOOR
#   end

#   def neighbor_coordinates
#     [
#       north,
#       south,
#       east,
#       west,
#       north_west,
#       north_east,
#       south_west,
#       south_east,
#     ]
#   end

#   def north
#     [x, (y + 1)]
#   end

#   def south
#     [x, (y - 1)]
#   end

#   def east
#     [(x + 1), y]
#   end

#   def west
#     [(x - 1), y]
#   end

#   def north_west
#     [(x - 1), (y + 1)]
#   end

#   def north_east
#     [(x + 1), (y + 1)]
#   end

#   def south_west
#     [(x - 1), (y - 1)]
#   end

#   def south_east
#     [(x + 1), (y - 1)]
#   end
# end

current_state = rows
seats_to_become_empty = [] #  represent as [x,] coordinates
seats_to_become_occupied  = [] # ''

consecutive_times_no_changes = 0

def adjacent_cells(rows, coordinates)
  row_index = coordinates.first
  col_index = coordinates.last

  north = [row_index, (col_index + 1)]
  south = [row_index, (col_index - 1)]
  east =  [(row_index + 1), col_index]
  west = [(row_index - 1), col_index]
  north_west = [(row_index - 1), (col_index + 1)]
  south_west = [(row_index -  1), (col_index - 1)]
  north_east = [(row_index + 1), (col_index + 1)]
  south_east = [(row_index + 1), (col_index - 1)]

  neighbor_coordinates = [north, south, east, west, north_west, south_west, north_east, south_east]

  neighbor_coordinates.map do |coord|
    if (pos = rows[coord.first] && rows[coord.first][coord.last])
      if [EMPTY, OCCUPIED].include?(pos) # ignore floor
        pos
      end
    end
  end.compact
end

while consecutive_times_no_changes < 2
  # loop
  rows.each_with_index do |row, row_index|
    row.each_with_index do |seat, col_index|
      current_coordinates = [row_index, col_index]

      if seat  == FLOOR
        next
      elsif seat == EMPTY
        # if there are no occupied adjacent seats next to it, becomes occupied
        neighbors  = adjacent_cells(rows,  current_coordinates)

        if neighbors.all? { |seat| seat ==  EMPTY }
          seats_to_become_occupied << current_coordinates
        end
      elsif seat == OCCUPIED
        # if 4 or more seats adjacent are occupied, it becomes empty
        occupied_neighbors = adjacent_cells(rows,  current_coordinates).select { |seat| seat == OCCUPIED }

        if occupied_neighbors.count >= 4
          seats_to_become_empty << current_coordinates
        end
      end
    end
  end

  if seats_to_become_empty.none? && seats_to_become_occupied.none?
    consecutive_times_no_changes += 1
  else
    consecutive_times_no_changes = 0

    seats_to_become_empty.each do |coordinates|
      rows[coordinates.first][coordinates[1]] = EMPTY
    end

    seats_to_become_occupied.each do |coordinates|
      rows[coordinates.first][coordinates[1]] = OCCUPIED
    end

    seats_to_become_empty = []
    seats_to_become_occupied = []
  end
end

occupied_seat_count = rows.map { |row| row.join("") }.join("").count(OCCUPIED)

puts "Occupied seat count is #{occupied_seat_count}!"


