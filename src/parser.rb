require '../src/lexical_analyzer'
require '../src/feature'
require '../src/id'
require '../src/parser_exception'
require '../src/compound'
require '../src/print_statement'
require '../src/assignment_statement'
require '../src/constant'

class Parser

  def initialize(file_name)
    if file_name.nil?
      raise TypeError, 'invalid file name argument'
    end
    @lex = LexicalAnalyzer.new(file_name)
  end

  def feature
    token = @lex.get_next_token
    match token, TokenType::FEATURE_TOK
    id_token = get_id
    token = @lex.get_next_token
    match token, TokenType::IS_TOK
    token = @lex.get_next_token
    match token, TokenType::DO_TOK
    compound = get_compound
    token = @lex.get_next_token
    unless token.get_token_type.eql? TokenType::END_TOK
      raise ParserException, "Garbage at end of program : #{token.get_token_type}"
    end
    Feature.new compound
  end

  def get_compound
    statement = get_statement
    compound = Compound.new
    compound.add(statement)
    token = @lex.get_look_ahead_token
    while is_valid_start token
      statement = get_statement
      compound.add statement
      token = @lex.get_look_ahead_token
    end
    compound.execute
  end

  def is_valid_start(token)
    if token.nil?
      raise ParserException, 'token is null'
    end
    token.get_token_type.eql? TokenType::ID_TOK or token.get_token_type.eql? TokenType::PRINT_TOK or
        token.get_token_type.eql? TokenType::IF_TOK or token.get_token_type.eql? TokenType::FROM_TOK
  end

  def get_statement
    token = @lex.get_look_ahead_token
    if token.get_token_type.eql? TokenType::ID_TOK
      statement = get_assignment_statement
    elsif token.get_token_type.eql? TokenType::PRINT_TOK
      statement = get_print_statement
    elsif token.get_token_type.eql? TokenType::IF_TOK
      statement = get_if_statement
    elsif token.get_token_type.eql? TokenType::FROM_TOK
      statement = get_loop_statement
    else
      raise ParserException, 'statement expected'
    end
    statement
  end

  def get_if_statement

  end

  def get_loop_statement

  end

  def get_print_statement
    token = @lex.get_next_token
    match token, TokenType::PRINT_TOK
    token = @lex.get_next_token
    match token, TokenType::LPARAN_TOK
    expression = get_expression
    token = @lex.get_next_token
    match token, TokenType::RPARAN_TOK
    PrintStatement.new expression
  end

  def get_assignment_statement
    input = get_id
    token = @lex.get_next_token
    match token, TokenType::ASSIGN_TOK
    expression = get_expression
    AssignmentStatement.new input.get_char, expression
  end

  def get_expression
    token = @lex.get_look_ahead_token
    if token.get_token_type.eql? TokenType::ID_TOK
      expression = get_id
    elsif token.get_token_type.eql? TokenType::CONST_TOK
      expression = get_literal_integer
    else
      operator = get_arithmetic_operator
      expression_1 = get_expression
      expression_2 = get_expression
      expression = BinaryExpression.new operator, expression_1, expression_2
    end
    expression
  end

  def get_literal_integer
    token = @lex.get_next_token
    match token, TokenType::CONST_TOK
    Constant.new token.get_lexeme
  end

  def get_id
    token = @lex.get_next_token
    match token, TokenType::ID_TOK
    lexeme = token.get_lexeme
    Id.new lexeme
  end

  def get_arithmetic_operator

  end

  def get_boolean_expression

  end

  def get_relational_operator

  end

  def match(token, token_type)
    unless token.get_token_type.eql? token_type
      raise TypeError, token_type + ' expected at row '+
          token.get_row_number.to_s + ' actual: ' + token.get_token_type
    end
  end
end