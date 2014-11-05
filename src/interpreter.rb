require '../src/parser'
class Interpreter

  def initialize
    puts 'Executing Interpreter...'
  end

  def execute
    p = Parser.new('/Users/thamilton/RubymineProjects/Project_2/test_data/test4.e')
    p.parse.execute
  end

end

@object = Interpreter.new
@object.execute

@memory = Memory.new
@memory.display_memory


