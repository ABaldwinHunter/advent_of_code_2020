OCCUPIED = "#"
FLOOR = "."
EMPTY = "L"

# FILE = 'input.txt'
FILE = 'sample.txt'


def print_board(rows)
  rows.each do |row|
    puts row.join("")
  end

  puts

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

# Part I

#while consecutive_times_no_changes < 1
#  # loop
#  #
#  # print_board(rows)

#  rows.each_with_index do |row, row_index|
#    row.each_with_index do |seat, col_index|
#      current_coordinates = [row_index, col_index]

#      if seat == EMPTY
#        # if there are no occupied adjacent seats next to it, becomes occupied
#        neighbors = adjacent_cells(rows,  current_coordinates)

#        if neighbors.all? { |seat| seat ==  EMPTY }
#          seats_to_become_occupied << current_coordinates
#        end
#      elsif seat == OCCUPIED
#        # if 4 or more seats adjacent are occupied, it becomes empty
#        occupied_neighbors = adjacent_cells(rows,  current_coordinates).select { |seat| seat == OCCUPIED }

#        if occupied_neighbors.count >= 4
#          seats_to_become_empty << current_coordinates
#        end
#      end
#    end
#  end

#  if seats_to_become_empty.none? && seats_to_become_occupied.none?
#    consecutive_times_no_changes += 1
#  else
#    consecutive_times_no_changes = 0

#    seats_to_become_empty.each do |coordinates|
#      rows[coordinates.first][coordinates.last] = EMPTY
#    end

#    seats_to_become_occupied.each do |coordinates|
#      rows[coordinates.first][coordinates.last] = OCCUPIED
#    end

#    seats_to_become_empty = []
#    seats_to_become_occupied = []
#  end
#end

#occupied_seat_count = rows.map { |row| row.join("") }.join("").count(OCCUPIED)

#puts "Occupied seat count is #{occupied_seat_count}!"

# Part II
#

def first_seat(start_row_index, start_col_index, row_change, col_change, rows)
  new_row_index = start_row_index + row_change
  new_col_index = start_col_index + col_change

  seat = begin
           if (new_row_index > 0 && new_col_index > 0) && (seat = rows[new_row_index] && rows[new_row_index][new_col_index])
             seat
           end
         end

  if [EMPTY, OCCUPIED, nil].include?(seat)
    seat
  else
    first_seat(new_row_index, new_col_index, row_change, col_change, rows)
  end
end

def visible_neighbors(rows, coordinates)
  row_index = coordinates.first
  col_index = coordinates.last

  east = first_seat(row_index, col_index, 0, 1, rows)
  west = first_seat(row_index, col_index, 0, -1, rows)
  south = first_seat(row_index, col_index, 1, 0, rows)
  north = first_seat(row_index, col_index, -1, 0, rows)
  north_east = first_seat(row_index, col_index, -1, 1, rows)
  north_west = first_seat(row_index, col_index, -1, -1, rows)
  south_east = first_seat(row_index, col_index, 1, 1, rows)
  south_west = first_seat(row_index, col_index, 1, -1, rows)

  visible_seats = [north, south, east, west, north_west, south_west, north_east, south_east]

  puts "visible  seats for #{row_index}, #{col_index}"
  p visible_seats
  visible_seats.compact
end

seats_to_become_empty = [] #  represent as [x,] coordinates
seats_to_become_occupied  = [] # ''

consecutive_times_no_changes = 0

rows = File.read(FILE).split("\n").map! { |row| row.split("") } # array of arrays

while consecutive_times_no_changes < 1
  # loop
  #
  print_board(rows)

  rows.each_with_index do |row, row_index|
    row.each_with_index do |seat, col_index|
      current_coordinates = [row_index, col_index]

      if seat == EMPTY
        # if none of the seats it can see are occupied it becomes occupied
        visible_neighbors = visible_neighbors(rows, current_coordinates)

        if visible_neighbors.all? { |seat| seat ==  EMPTY }
          seats_to_become_occupied << current_coordinates
        end
      elsif seat == OCCUPIED
        # if 5 or more seats adjacent are occupied, it becomes empty
        occupied_visible_neighbors = visible_neighbors(rows, current_coordinates).select { |seat| seat == OCCUPIED }

        if occupied_visible_neighbors.count >= 5
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
