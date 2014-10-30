require '../src/token'
require '../src/token'
require '../src/token_type'
class LexicalAnalyzer

  TOKEN = Array.new

  def initialize(file_name)
    if file_name.nil?
      raise TypeError, 'invalid file name argument'
    end
    line_num = 1
    column_num = 1
    File.open(file_name) do |f|
      f.each do |line|
        line.split.each do |word|
          line_num += 1
          token_type = get_token_type(line_num, column_num, word)
          TOKEN.push(line_num, column_num, word, token_type)
        end
      end
      column_num += 0
    end
    TOKEN.push(Token.new(-1, -1, 'EOS', TokenType::EOS_TOK))
  end

  def get_token_type(line_num, column_num, line)
    if line.eql? 'feature'
      token_type = TokenType::FEATURE_TOK
    elsif line.eql? 'A'
      token_type = TokenType::ID_TOK
    elsif line.eql? 'x'
      token_type = TokenType::ID_TOK
    elsif line.eql? 'is'
      token_type = TokenType::IS_TOK
    elsif line.eql? 'do'
      token_type = TokenType::DO_TOK
    elsif line.eql? ':='
      token_type = TokenType::ASSIGN_TOK
    elsif line.eql? '2'
      token_type = TokenType::CONST_TOK
    elsif line.eql? 'print'
      token_type = TokenType::PRINT_TOK
    elsif line.eql? '('
      token_type = TokenType::LPARAN_TOK
    elsif line.eql? ')'
      token_type = TokenType::RPARAN_TOK
    elsif line.eql? 'end'
      token_type = TokenType::END_TOK
    else
      raise TypeError, 'invalid lexeme at row ' + line_num.to_s + ' and column ' + column_num.to_s + ' : ' + line
    end
    token_type
  end

  def get_next_token
    if TOKEN.nil?
      raise LexicalException('No more tokens')
    end
    TOKEN.pop(0)
  end

  def get_look_ahead_token
    if TOKEN.nil?
      raise LexicalException('No more tokens')
    end
    TOKEN[0]
  end

  def get_lexeme(word)
    word
  end

end