require 'pry'

class CreditCard
  def initialize(name, zip, card_number, expiration, ccv)
    @name = name
    @zip = zip
    @card_number = card_number
    @expiration = expiration
    @ccv = ccv
  end

  def name
    @name
  end

  def zip
    @zip
  end

  def card_number
    @card_number
  end

  def expiration
    @expiration
  end

  def ccv
    @ccv
  end

  def valid?
    valid_name? && valid_zip? && valid_expiration? && valid_card_number?
  end

# consider using something like:
# if name && !(name.empty?)
  def valid_name?
    @name && !(@name.empty?)
  end

  def valid_zip?
    @zip.length == 5
  end

  def valid_expiration?
    @expiration - Time.now > 0
  end

  def convert_to_array
    array = card_number.to_s.chars.map { |number| number.to_i }
    array.map { |item| item.to_i }
  end

  def cc_num_pop
    array = convert_to_array
    @cc_popped_num = array.pop
    array
  end

  def cc_num_reverse
    cc_num_pop.reverse
  end

  def mutate_array
    product = []
    cc_num_reverse.each_with_index do |item, index|
      if index % 2 == 0
        item * 2 > 9 ? product << (item * 2) - 9 : product << item * 2
      else
        product << item
      end
    end
    product
  end

  def sum_array
    mutate_array.reduce(:+) + @cc_popped_num
  end

# There seem to be multiple versions of the Luhn algorithm
# This is from http://www.freeformatter.com/credit-card-number-generator-validator.html
# Drop the last digit from the number. The last digit is what we want to check against
# Reverse the numbers
# Multiply the digits in odd positions (1, 3, 5, etc.) by 2 and subtract 9 to all any result higher than 9
# Add all the numbers together
# The check digit (the last number of the card) is the amount that you would need to add to get a multiple of 10 (Modulo 10)
  # def valid_card_number?
  #   card_num_array = @card_number.to_s.chars.map { |number| number.to_i }
  #   check_digit = card_num_array.pop
  #   card_num_array.reverse!
  #   card_num_array.each_with_index do |number, index|
  #     if index % 2 == 0
  #       card_num_array[index] *= 2
  #       if card_num_array[index] > 9
  #         card_num_array[index] -= 9
  #       end
  #     end
  #   end
  #   ( card_num_array.reduce(:+) + check_digit ) % 10 == 0
  # end
  def valid_card_number?
    sum_array % 10 == 0
  end

  def card_type
  end
end
