module Enumerable
  def my_each_with_index(&block)
    index = 0
    self.my_each do |element|
      yield [element, index]
      index += 1
    end
  end

  def my_select(&block)
    result = []
    self.my_each do |element|
      condition = yield element
      result << element if condition
    end
    result
  end

  def my_all?(&block)
    result = true
    self.my_each do |element|
      condition = yield element
      result = false unless condition
    end
    result
  end

  def my_any?(&block)
    result = false
    self.my_each do |element|
      condition = yield element
      result = true if condition
    end
    result
  end

  def my_none?(&block)
    !self.my_any? &block
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each
    enum = self.to_enum
    if block_given?
      loop do
        yield enum.next
      end
      self
    else
      enum
    end
  end
end

array = [1, 1, 2, 3, 5, 8, 13, 21, 34]
# p array.my_each { |e| puts "Reading #{e}" }
# p array.my_each
# p array.my_each_with_index { |e, i| puts "Reading #{e} at index #{i}" }
# p array.my_each_with_index
# p array.my_select { |e| e > 5 }
# p array.my_all? { |e| e > 1 }
# p array.my_any? { |e| e < 1 }
# p array.my_none? { |e| e < 2 }
