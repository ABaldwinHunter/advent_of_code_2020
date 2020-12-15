nums = [17,1,3,16,19,0]

num_map = {
  17 => [1],
  1 => [2],
  3 => [3],
  16 => [4],
  19 => [5],
  0 => [6],
}


turn = 7
last_spoken = 0

PART_1 = 2021
PART_2 = 30000001

while turn < PART_2
  if num_map[last_spoken].length > 1 # had been spoken before
    length = num_map[last_spoken].length

    last = num_map[last_spoken].last
    second_to_last = num_map[last_spoken][(length - 2)]

    diff = last - second_to_last

    last_spoken = diff
  else
    last_spoken = 0
  end


  if num_map[last_spoken]
    num_map[last_spoken] << turn
  else
    num_map[last_spoken] = [turn]
  end

  turn += 1

  puts "Turn is #{turn}"
end

puts "last spoken is #{last_spoken}"
