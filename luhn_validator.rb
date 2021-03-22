module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    # TODO: use the integers in nums_a to validate its last check digit
    sum_odd = 0
    sum_even = 0
    number.reverse.chars.each_slice(2) do |char_odd, char_even|
      num_odd = char_even.to_i * 2
      num_odd >= 10 ? num_odd -= 9 : num_odd 
      sum_odd += num_odd
      sum_even += char_odd.to_i
    end
    (sum_odd + sum_even) % 10 == 0 ? true : false
  end
end
