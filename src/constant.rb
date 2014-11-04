require '../src/expression'
class Constant < Expression

  attr_accessor :value

  def initialize(value)
    if value.nil?
      raise TypeError, '[Constant] null value argument'
    end
    @value = value
  end

  def evaluate
    @value
  end

end