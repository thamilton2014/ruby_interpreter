class IfStatement < Statement

  attr_accessor :boolean_expression, :compound_1, :compound_2

  def initialize(boolean_expression, compound_1, compound_2)
    if boolean_expression.nil?
      raise TypeError, '[If Statement] boolean expression is null'
    end
    if compound_1.nil? or compound_2.nil?
      raise TypeError, '[If Statement] compound is null'
    end
    @boolean_expression = boolean_expression
    @compound_1 = compound_1
    @compound_2 = compound_2
  end

  def execute
    if @boolean_expression.evaluate
      @compound_1.execute
    else
      @compound_2.execute
    end
  end

end