require '../src/expression'
require '../src/arithmetic_operator'
class BinaryExpression < Expression

  attr_accessor :operator, :expression_1, :expression_2

  def initialize(operator, expression_1, expression_2)
    if operator.nil?
      raise TypeError, '[Binary Expression] operator is null'
    end
    if expression_1.nil? or expression_2.nil?
      raise TypeError, '[Binary Expression] expression is null'
    end
    @operator = operator
    @expression_1 = expression_1
    @expression_2 = expression_2
  end

  def evaluate
    if @operator.eql? ArithmeticOperator::ADD_OP
      value = (@expression_1.evaluate).to_i + (@expression_2.evaluate).to_i
    elsif @operator.eql? ArithmeticOperator::SUB_OP
      value = (@expression_1.evaluate).to_i - (@expression_2.evaluate).to_i
    elsif @operator.eql? ArithmeticOperator::MUL_OP
      value = (@expression_1.evaluate).to_i * (@expression_2.evaluate).to_i
    else
      value = (@expression_1.evaluate).to_i / (@expression_2.evaluate).to_i
    end
    value
  end

end