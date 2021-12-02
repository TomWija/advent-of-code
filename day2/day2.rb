input = File.readlines('input.txt')

def get_position(planned_course)
  horizontal = 0
  depth = 0

  planned_course.each do |instruction|
    direction, value = instruction.split

    if direction == 'forward'
      horizontal += value.to_i
    else
      direction == 'up' ? depth -= value.to_i : depth += value.to_i
    end
  end

  horizontal * depth
end

puts get_position(input)

def get_position_with_aim(planned_course)
  horizontal = 0
  depth = 0
  aim = 0

  planned_course.each do |instruction|
    direction, value = instruction.split

    if direction == 'forward'
      horizontal += value.to_i
      depth += value.to_i * aim
    else
      direction == 'up' ? aim -= value.to_i : aim += value.to_i
    end
  end

  horizontal * depth
end

puts get_position_with_aim(input)