require '../src/expression'
class Id < Expression

  attr_accessor :character

  def initialize(character)
    if character.nil?
      raise TypeError, '[Id] character is null'
    end
    @character = character
  end

  def evaluate
    @memory = Memory.new
    @memory.fetch(character)
  end

  def get_char
    @character
  end

end