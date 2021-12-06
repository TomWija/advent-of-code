lanternfish = File.readlines('input.txt')[0].split(',').map(&:to_i)

# Part 1
def part1(lanternfish, max_days = 80)
  days = 0
  until days == max_days
    (0..lanternfish.length - 1).each do |index|
      if lanternfish[index].zero?
        lanternfish[index] = 6
        lanternfish.push(8)
      else
        lanternfish[index] -= 1
      end
    end
    days += 1
  end
  lanternfish.length
end

puts part1(lanternfish.clone)

# Part 2
def initialise_counter(lanternfish)
  counter = {}
  (0..8).each do |i|
    counter[i] = 0
  end

  lanternfish.each do |i|
    counter[i] += 1
  end

  counter
end

def part2(lanternfish, days=256)
  counter = initialise_counter(lanternfish)

  days.times do
    temp = counter[0]
    (0..7).each do |fish|
      counter[fish] = counter[fish + 1]
    end

    counter[6] += temp
    counter[8] = temp
  end

  counter.values.inject(:+)
end

puts part2(lanternfish.clone)
