OCCUPIED = "#"
FLOOR = "."
EMPTY = "L"

FILE = 'input.txt'
# FILE = 'sample.txt'


def print_board(rows)
  rows.each do |row|
    puts row.join(" ")
  end

  sleep 0.5
end

# [
#   [1,2,3],
#   [4,5,6],
#   [4,5,6],
# ]


def adjacent_cells(rows, coordinates) # [row_index, col_index]
  row_index = coordinates.first
  col_index = coordinates.last

  east = [row_index, (col_index + 1)]
  west = [row_index, (col_index - 1)]
  south =  [(row_index + 1), col_index]
  north = [(row_index - 1), col_index]
  north_east = [(row_index - 1), (col_index + 1)]
  north_west = [(row_index - 1), (col_index - 1)]
  south_east = [(row_index + 1), (col_index + 1)]
  south_west = [(row_index + 1), (col_index - 1)]

  neighbor_coordinates = [north, south, east, west, north_west, south_west, north_east, south_east]

  neighbor_coordinates.map do |coord|
    if (coord.all? { |num| num >= 0 }) && (pos = rows[coord.first] && rows[coord.first][coord.last])
      if [EMPTY, OCCUPIED].include?(pos) # ignore floor
        pos
      end
    end
  end.compact
end

rows = File.read(FILE).split("\n").map! { |row| row.split("") } # array of arrays

seats_to_become_empty = [] #  represent as [x,] coordinates
seats_to_become_occupied  = [] # ''

consecutive_times_no_changes = 0

while consecutive_times_no_changes < 1
  # loop
  #
  # print_board(rows)

  rows.each_with_index do |row, row_index|
    row.each_with_index do |seat, col_index|
      current_coordinates = [row_index, col_index]

      if seat == EMPTY
        # if there are no occupied adjacent seats next to it, becomes occupied
        neighbors = adjacent_cells(rows,  current_coordinates)

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
      rows[coordinates.first][coordinates.last] = EMPTY
    end

    seats_to_become_occupied.each do |coordinates|
      rows[coordinates.first][coordinates.last] = OCCUPIED
    end

    seats_to_become_empty = []
    seats_to_become_occupied = []
  end
end

occupied_seat_count = rows.map { |row| row.join("") }.join("").count(OCCUPIED)

puts "Occupied seat count is #{occupied_seat_count}!"