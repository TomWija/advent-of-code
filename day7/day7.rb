positions = File.readlines('input.txt')[0].split(',').map(&:to_i)

max_position = positions.max
min_position = positions.min
min_fuel_cost = [-1, -1]

# part 1
(min_position..max_position).each do |target_position|
  sum = 0
  positions.each do |current_position|
    sum += (target_position - current_position).abs
    break if sum >= min_fuel_cost[1] && min_fuel_cost[1] != -1
  end
  min_fuel_cost = [target_position, sum] if sum < min_fuel_cost[1] || min_fuel_cost[1] == -1
end

print min_fuel_cost

# part 2
min_fuel_cost = [-1, -1]

def get_triangle_number(n)
  n * (n + 1) / 2
end

(min_position..max_position).each do |target_position|
  sum = 0
  positions.each do |current_position|
    delta = (target_position - current_position).abs
    sum += get_triangle_number(delta)
    break if sum >= min_fuel_cost[1] && min_fuel_cost[1] != -1
  end
  min_fuel_cost = [target_position, sum] if sum < min_fuel_cost[1] || min_fuel_cost[1] == -1
end

print min_fuel_cost
