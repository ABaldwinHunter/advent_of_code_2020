instructions = File.read("input.txt").split("\n")

def execute_instructions(instructions:, visited:, current_index:, accumulator: 0)
  if visited.include?(current_index)
    puts "Infinite loop detected! Accumulator is #{accumulator}"
  else
    visited << current_index
    instr = instructions[current_index]
    action, amount = instr.split(" ")

    amount_parts = amount.split /\d+ /

    num = amount_parts.last.to_i
    sign = amount_parts.first

    if action == 'jmp'
      if sign == "-"
        current_index -= num
      else
        current_index += num
      end
    elsif action == "nop"
      current_index += 1
    else
      current_index += 1

      if sign == "-"
        accumulator -= num
      else
        accumulator += num
      end
    end

    execute_instructions(instructions: instructions, visited: visited, current_index: current_index, accumulator: accumulator)
  end
end

execute_instructions(instructions: instructions, visited: [], current_index: 0, accumulator: 0)

# part II
#
# brute force

# hackiest thing ever - ran the method below without reference to this constant, and got System stack level too deep error, with 5447 levels
#
# So, I just copy pasted the "already_tested" output into this constant, and then didn't test those :D
#
NOT_IT = [1, 188, 315, 363, 438, 468, 145, 64, 131, 58, 60, 333, 260, 261, 271, 272, 207, 209, 210, 227, 571, 380, 581, 541, 327, 354, 250, 251, 253, 449, 193, 195, 197, 298, 301, 525, 526, 42, 442, 578, 352, 24, 26, 283, 180, 90, 6, 8, 9]

def execute_instructions(instructions:, visited:, current_index:, accumulator:, currently_testing:, already_tested:)
  if instructions[current_index].nil?
    puts "Current index is #{current_index}"
    puts "Accumulator is #{accumulator}"
  elsif visited.include?(current_index)
    puts "Infinite loop detected! Was testing index #{currently_testing}"

    p already_tested

    execute_instructions(instructions: instructions, visited: [], current_index: 0, accumulator: 0, currently_testing: nil, already_tested: already_tested)
  else
    visited << current_index
    instr = instructions[current_index]
    action, amount = instr.split(" ")

    amount_parts = amount.split /\d+ /

    num = amount_parts.last.to_i
    sign = amount_parts.first

    if currently_testing.nil? && !already_tested.include?(current_index) && ["jmp", "nop"].include?(action) && !NOT_IT.include?(current_index)
      currently_testing = current_index

      already_tested << currently_testing

      if action == 'jmp'
        action = 'nop'
      elsif action == 'nop'
        action = 'jmp'
      end
    end

    if action == 'jmp'
      if sign == "-"
        current_index -= num
      else
        current_index += num
      end
    elsif action == "nop"
      current_index += 1
    else
      current_index += 1

      if sign == "-"
        accumulator -= num
      else
        accumulator += num
      end
    end

    execute_instructions(instructions: instructions, visited: visited, current_index: current_index, accumulator: accumulator, currently_testing: currently_testing, already_tested: already_tested)
  end
end

execute_instructions(instructions: instructions, visited: [], current_index: 0, accumulator: 0, already_tested: [], currently_testing: nil)
