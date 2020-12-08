instructions = File.read("input.txt").split("\n")

visited = []

start = 0

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
