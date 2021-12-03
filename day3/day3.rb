input = File.readlines('input.txt')

# Part 1
def get_most_common_bit(bit_index, diagnostic_report)
  one_count = 0
  zero_count = 0

  diagnostic_report.each { |binary_value| binary_value[bit_index] == '0' ? zero_count += 1 : one_count += 1 }

  zero_count > one_count ? '0' : '1'
end

def get_power_usage(diagnostic_report)
  binary_length = diagnostic_report[0].length
  gamma_value = ''
  epsilon_value = ''

  (0...binary_length - 1).each do |bit_index|
    common_bit = get_most_common_bit(bit_index, diagnostic_report)
    gamma_value += common_bit
    epsilon_value += common_bit == '0' ? '1' : '0'
  end

  gamma_value.to_i(2) * epsilon_value.to_i(2)
end

puts get_power_usage(input)

# Part 2

def get_life_support_rating(arr, type, bit_index = 0)
  return arr[0].to_i(2) if arr.length == 1 || bit_index > 12

  zero_values, one_values = arr.partition { |x| x[bit_index] == '0' }
  
  if type == 'c02'
    return zero_values.length <= one_values.length ?
      get_life_support_rating(zero_values, type, bit_index + 1) :
      get_life_support_rating(one_values, type, bit_index + 1)
  else
    return one_values.length >= zero_values.length ?
      get_life_support_rating(one_values, type, bit_index + 1) :
      get_life_support_rating(zero_values, type, bit_index + 1)
  end
end

puts get_life_support_rating(input, 'c02') * get_life_support_rating(input, 'oxygen')
