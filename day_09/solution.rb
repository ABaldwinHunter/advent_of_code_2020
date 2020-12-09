#
# part I brute force solution
#
NUMS = File.read("input.txt").split("\n").map(&:to_i)

NUM_HASH = {}

NUMS.each.with_index do |num, i|
  if NUM_HASH[num]
    NUM_HASH[num] << i
  else
    NUM_HASH[num] = [i]
  end
end

# first 0-24 are keep
index_start = 25

NUMS.each_with_index do |num, i|
  if i <= 24
    next
  else
    look_back_start = i - 25
    look_back_end = i - 1

    match = (look_back_start..look_back_end).any? do |index|
      previous_num = NUMS[index]

      target_counterpart = num - previous_num

      if NUM_HASH[target_counterpart] && NUM_HASH[target_counterpart].any? { |ii| ii >= look_back_start && ii <= look_back_end && ii != index }
        true
      else
        false
      end
    end

    if match
      next
    else
      puts "Found it! #{num}"
      break
    end

  end
end
