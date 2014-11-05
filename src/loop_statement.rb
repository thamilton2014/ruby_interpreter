class LoopStatement

  attr_accessor :statement, :boolean_expression, :compound

  def initialize(statement, boolean_expression, compound)
    if statement.nil?
      raise TypeError, '[Loop Statement] null statement'
    end
    if boolean_expression.nil?
      raise TypeError, '[Loop Statement] null boolean expression'
    end
    if compound.nil?
      raise TypeError, '[Loop Statement] null compound'
    end
    @statement = statement
    @boolean_expression = boolean_expression
    @compound = compound
  end

  def execute
    @statement.execute
    until @boolean_expression.evaluate do
      @compound.execute
    end
  end

end