require '../src/lexical_analyzer'
class Parser

  attr_accessor :lex

  def initialize(file_name)
    if file_name.nil?
      raise TypeError, 'invalid file name argument'
    end
    LexicalAnalyzer.new(file_name)
  end

  def feature

  end

  def get_compound

  end

  def is_valid_start

  end

  def get_statement

  end

  def get_loop_statement

  end

  def get_print_statement

  end

  def get_assignment_statement

  end

  def get_expression

  end

  def get_literal_integer

  end

  def get_id

  end

  def get_arithmetic_operator

  end

  def get_boolean_expression

  end

  def get_relational_operator

  end

  def get_next_token
    @lex.get_next_token
  end

  def get_look_ahead_token
    @lex.get_next_token
  end

  def match(token, token_type)
    unless token.eql? token_type
      raise TypeError, token_type + ' expected at row '+
          token.get_row_number + ' and column ' + token.get_column_number
    end
  end
end