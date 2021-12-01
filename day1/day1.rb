# frozen_string_literal: true

# Read in the puzzle input and each value to an integer
depths = File.readlines('input.txt').map(&:to_i)


# Needed for both Part 1 and Part 2. Increments a counter whenever any depth is higher than a previous one.
def get_increased_depths(sonar_depths)
  count = 0
  prev_depth = -1

  sonar_depths.each do |depth|
    count += 1 if prev_depth >= 0 && depth > prev_depth
    prev_depth = depth
  end

  count
end

puts "Part One, times depth increased: #{get_increased_depths(depths)}"

# Used only in Part 2 to sum a sliding window of values.
def sum_depths(sonar_depths)
  summed_depths = []
  sonar_depths.each_index do |index|
    break if index + 2 == sonar_depths.length

    summed_depths.push(sonar_depths.slice(index, 3).sum)
  end

  summed_depths
end

summed_depths = sum_depths(depths)

puts "Part Two, times depth increased: #{get_increased_depths(summed_depths)}"
