require 'pry-byebug'
class CreditCard

  def initialize(number:, exp:, ccv:, name:, zip:)
    @number = number
    @exp = exp
    @ccv = ccv
    @name = name
    @zip = zip
  end

  def hasName?
    @name.length > 0
  end

  def validZip?
    @zip.length == 5
  end

  def validNum?
    array = @number.chars.reverse
    if array.length != 16
      return false
    end
    total = 0
    array.each_index do |i|
      if i % 2 == 1
        array[i] = 2 * array[i].to_i
      end
      total += sumDig(array[i])
    end
    total % 10 == 0
  end

  def validDate?
    @exp - Time.new(Time.now.year, Time.now.month) >= 0
  end

  def company
    if @number[0].to_i == 3
      "American Express"
    elsif @number[0].to_i == 4
      "Visa"
    elsif @number[0].to_i == 5
      "MasterCard"
    elsif @number[0].to_i == 6
      "Discover"
    else
      "I don't know."
    end
  end

  def valid?
    hasName? && validZip? && validNum? && validDate?
  end

  private

  def sumDig (num)
    ary = num.to_s.chars
    ary.map { |x| x.to_i}.reduce(:+)
  end

end
