class Token

  def initialize(line_num, token_type, word)
    if line_num.nil?
      raise TypeError, '[Token] invalid column/row number argument'
    end
    if word.nil?
      raise TypeError, '[Token] invalid line argument'
    end
    if token_type.nil?
      raise TypeError, '[Token] invalid TokenType argument'
    end
    @line_num = line_num
    @word = word
    @token_type = token_type
  end

  def get_row_number
    @line_num
  end

  def get_lexeme
    @word
  end

  def get_token_type
    @token_type
  end

end