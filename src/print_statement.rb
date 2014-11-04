require '../src/statement'
class PrintStatement < Statement

  attr_accessor :expression

  def initialize(expression)
    if expression.nil?
      raise TypeError, '[Print Statement] expression is null'
    end
    @expression = expression
  end

  def execute
    puts '[Print Statement] ' + @expression.evaluate.to_s
  end

end