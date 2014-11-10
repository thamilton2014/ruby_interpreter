require '../src/token'
require '../src/token'
require '../src/token_type'
class LexicalAnalyzer

  TOKEN = []

  def initialize(file_name)
    if file_name.nil?
      raise TypeError, 'invalid file name argument'
    end
    line_num = 0
    File.open(file_name) do |f|
      f.each do |line|
        line.split.each do |word|
          line_num += 1
          token_type = get_token_type(line_num, word)
          @tokens = TOKEN.push(Token.new(line_num, token_type, word))
        end
      end
    end
    # TOKEN.push(Token.new(-1, 'EOS', TokenType::EOS_TOK))
  end

  def get_token_type(line_num, line)
    if line.eql? 'feature'
      token_type = TokenType::FEATURE_TOK
    elsif line.length == 1 and line =~ /[A-Za-z]/
      token_type = TokenType::ID_TOK
    elsif line.eql? 'is'
      token_type = TokenType::IS_TOK
    elsif line.eql? 'do'
      token_type = TokenType::DO_TOK
    elsif line.eql? ':='
      token_type = TokenType::ASSIGN_TOK
    elsif line =~ /[0-9]+/
      token_type = TokenType::CONST_TOK
    elsif line.eql? 'print'
      token_type = TokenType::PRINT_TOK
    elsif line.eql? '('
      token_type = TokenType::LPARAN_TOK
    elsif line.eql? ')'
      token_type = TokenType::RPARAN_TOK
    elsif line.eql? 'end'
      token_type = TokenType::END_TOK
    elsif line.eql? 'if'
      token_type = TokenType::IF_TOK
    elsif line.eql? 'then'
      token_type = TokenType::THEN_TOK
    elsif line.eql? 'else'
      token_type = TokenType::ELSE_TOK
    elsif line.eql? '>'
      token_type = TokenType::GT_TOK
    elsif line.eql? '>='
      token_type = TokenType::GE_TOK
    elsif line.eql? '<'
      token_type = TokenType::LT_TOK
    elsif line.eql? '<='
      token_type = TokenType::LE_TOK
    elsif line.eql? '/='
      token_type = TokenType::NE_TOK
    elsif line.eql? '=='
      token_type = TokenType::EQ_TOK
    elsif line.eql? 'from'
      token_type = TokenType::FROM_TOK
    elsif line.eql? 'until'
      token_type = TokenType::UNTIL_TOK
    elsif line.eql? 'loop'
      token_type = TokenType::LOOP_TOK
    elsif line.eql? '+'
      token_type = TokenType::ADD_TOK
    elsif line.eql? '-'
      token_type = TokenType::SUB_TOK
    elsif line.eql? '*'
      token_type = TokenType::MUL_TOK
    elsif line.eql? '/'
      token_type = TokenType::DIV_TOK
    else
      raise TypeError, 'invalid lexeme at row ' + line_num.to_s + ' : ' + line
    end
    token_type
  end

  def get_next_token
    if TOKEN.nil?
      raise LexicalException('No more tokens')
    end
    TOKEN.fetch(0)
    TOKEN.shift
  end

  def get_look_ahead_token
    if TOKEN.nil?
      raise LexicalException('No more tokens')
    end
    TOKEN.fetch(0)
  end

  def get_lexeme(word)
    word
  end

end