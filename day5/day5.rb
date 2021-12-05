class Transform
  def initialize(coordinates)
    @x1 = coordinates[0][0]
    @x2 = coordinates[1][0]
    @y1 = coordinates[0][1]
    @y2 = coordinates[1][1]
  end

  def print_points
    puts "#{@x1},#{@y1} => #{@x2},#{@y2}"
  end

  def get_point_range(point_a, point_b)
    if point_a < point_b
      (point_a..point_b)
    else
      (point_b..point_a)
    end
  end

  def points
    if @x1 == @x2
      get_point_range(@y1, @y2).map { |y| [@x1, y] }
    elsif @y1 == @y2
      get_point_range(@x1, @x2).map { |x| [x, @y1] }
    else
      points = []
      range = (@x1 - @x2).abs
      (0..range).each do |i|
        point = []
        point[0] = @x1 > @x2 ? @x1 - i : @x1 + i
        point[1] = @y1 > @y2 ? @y1 - i : @y1 + i
        points.push(point)
      end
      points
    end
  end
end

input = File.readlines('input.txt')
transforms = input.map { |item| item.gsub("\n", '').split(' -> ') }
valid_transforms = transforms.map { |transform| transform.map { |coordinates| coordinates.split(',').map(&:to_i) } }

# Part 1
# Returns only transforms that move on the same axis, straight lines.
filtered_transforms = valid_transforms.reject { |transform| transform[0][0] != transform[1][0] && transform[0][1] != transform[1][1]}
                                      .map { |transform| Transform.new(transform) }

point_map = {}
crossings = 0

filtered_transforms.each do |transform|
  transform.points.each do |point|
    if point_map[point]
      crossings += 1 unless point_map[point] >= 2
      point_map[point] += 1
    else
      point_map[point] = 1
    end
  end
end

puts crossings

# Part 2
classed_transforms = valid_transforms.map { |transform| Transform.new(transform) }

point_map = {}
crossings = 0

classed_transforms.each do |transform|
  transform.points.each do |point|
    if point_map[point]
      crossings += 1 unless point_map[point] >= 2
      point_map[point] += 1
    else
      point_map[point] = 1
    end
  end
end

puts crossings
