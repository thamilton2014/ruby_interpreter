require '../src/statement'
require '../src/memory'
class AssignmentStatement < Statement

  attr_accessor :input, :expression

  def initialize(input, expression)
    if input.nil?
      raise TypeError, '[Assignment Statement] input is null'
    end
    if expression.nil?
      raise TypeError, '[Assignment Statement] expression is null'
    end
    @input = input
    @expression = expression
  end

  def execute
    memory = Memory.new
    memory.store(@input, @expression.evaluate)
  end
end