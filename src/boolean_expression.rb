require '../src/relational_operator'
class BooleanExpression

  attr_accessor :operator, :expression_1, :expression_2

  def initialize(operator, expression_1, expression_2)
    if operator.nil?
      raise TypeError, '[Boolean Expression] operator is null'
    end
    if expression_1.nil? or expression_2.nil?
      raise TypeError, '[Boolean Expression] expression is null'
    end
    @operator = operator
    @expression_1 = expression_1
    @expression_2 = expression_2
  end

  def evaluate
    if @operator.eql? RelationalOperator::LE_OP
      value = (expression_1.evaluate).to_i <= (expression_2.evaluate).to_i
    elsif @operator.eql? RelationalOperator::LT_OP
      value = (expression_1.evaluate).to_i < (expression_2.evaluate).to_i
    elsif @operator.eql? RelationalOperator::GT_OP
      value = (expression_1.evaluate).to_i > (expression_2.evaluate).to_i
    elsif @operator.eql? RelationalOperator::GE_OP
      value = (expression_1.evaluate).to_i >= (expression_2.evaluate).to_i
    elsif @operator .eql? RelationalOperator::EQ_OP
      value = (expression_1.evaluate).to_i == (expression_2.evaluate).to_i
    else
      value = (expression_1.evaluate).to_i != (expression_2.evaluate).to_i
    end
    value
  end

end