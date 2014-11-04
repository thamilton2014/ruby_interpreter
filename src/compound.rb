class Compound

  attr_accessor :statements

  def initialize
    @statements = []
  end

  def add(statement)
    if statement.nil?
      raise TypeError, '[Compound] statement is null'
    end
    @statements.push statement
  end

  def execute
    @statements.each do |statement|
      statement.execute
    end
  end

end