require '../src/lexical_analyzer'
require '../src/feature'
require '../src/id'
require '../src/parser_exception'
require '../src/compound'
require '../src/print_statement'
require '../src/assignment_statement'
require '../src/constant'
require '../src/if_statement'
require '../src/boolean_expression'
require '../src/binary_expression'
require '../src/lexical_exception'
require '../src/loop_statement'
require '../src/relational_operator'
require '../src/token_type'
require '../src/arithmetic_operator'

class Parser

  def initialize(file_name)
    if file_name.nil?
      raise TypeError, 'invalid file name argument'
    end
    @lex = LexicalAnalyzer.new(file_name)
  end

  def parse
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
      compound.add(statement)
      token = @lex.get_look_ahead_token
    end
    compound
  end

  def is_valid_start(token)
    if token.nil?
      raise ParserException, 'token is null'
    end
    token.get_token_type.eql? TokenType::ID_TOK or
        token.get_token_type.eql? TokenType::PRINT_TOK or
        token.get_token_type.eql? TokenType::IF_TOK or
        token.get_token_type.eql? TokenType::FROM_TOK
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
    token = get_next_token
    match(token, TokenType::IF_TOK)
    boolean_expression = get_boolean_expression
    token = get_next_token
    match(token, TokenType::THEN_TOK)
    compound_1 = get_compound
    token = get_next_token
    match(token, TokenType::ELSE_TOK)
    compound_2 = get_compound
    token = get_next_token
    match(token, TokenType::END_TOK)
    IfStatement.new(boolean_expression, compound_1, compound_2)
  end

  def get_loop_statement
    token = get_next_token
    match(token, TokenType::FROM_TOK)
    statement = get_assignment_statement
    token = get_next_token
    match(token, TokenType::UNTIL_TOK)
    boolean_expression = get_boolean_expression
    token = get_next_token
    match(token, TokenType::LOOP_TOK)
    compound = get_compound
    token = get_next_token
    match(token, TokenType::END_TOK)
    LoopStatement.new(statement, boolean_expression, compound)
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
    token = get_next_token
    if token.get_token_type == TokenType::ADD_TOK
      operator = ArithmeticOperator::ADD_OP
    elsif token.get_token_type == TokenType::SUB_TOK
      operator = ArithmeticOperator::SUB_OP
    elsif token.get_token_type == TokenType::MUL_TOK
      operator = ArithmeticOperator::MUL_OP
    elsif token.get_token_type == TokenType::DIV_TOK
      operator = ArithmeticOperator::DIV_OP
    else
      raise ParserException, 'arithmetic operator expected.'
    end
    operator
  end

  def get_boolean_expression
    operator = get_relational_operator
    expression_1 = get_expression
    expression_2 = get_expression
    BooleanExpression.new(operator, expression_1, expression_2)
  end

  def get_relational_operator
    token = get_next_token
    if token.get_token_type == TokenType::EQ_TOK
      operator = RelationalOperator::EQ_OP
    elsif token.get_token_type == TokenType::NE_TOK
      operator = RelationalOperator::NE_OP
    elsif token.get_token_type == TokenType::GT_TOK
      operator = RelationalOperator::GT_OP
    elsif token.get_token_type == TokenType::GE_TOK
      operator = RelationalOperator::GE_OP
    elsif token.get_token_type == TokenType::LT_TOK
      operator = RelationalOperator::LT_OP
    elsif token.get_token_type == TokenType::LE_TOK
      operator = RelationalOperator::LE_OP
    else
      raise ParserException, 'relational operator expected'
    end
    operator
  end

  def get_next_token
    @lex.get_next_token
  end

  def get_look_ahead_token
    @lex.get_look_ahead_token
  end

  def match(token, token_type)
    unless token.get_token_type.eql? token_type
      raise TypeError, token_type + ' expected at row '+
          token.get_row_number.to_s + ' actual: ' + token.get_token_type
    end
  end
end