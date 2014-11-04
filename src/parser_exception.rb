class ParserException < Exception
  def initialize(input)
    puts '[Parser Exception] ' + input
  end
end