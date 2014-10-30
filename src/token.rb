class Token
  def initialize(line_num, column_num, line, token_type)
    if line_num.nil? || column_num.nil?
      raise TypeError, '[Token] invalid column/row number argument'
    end
    if line.nil?
      raise TypeError, '[Token] invalid line argument'
    end
    if token_type.nil?
      raise TypeError, '[Token] invalid TokenType argument'
    end
    @line_num = line_num
    @column_num = column_num
    @line = line
    @token_type = token_type
  end

  def get_row_number
    @line_num
  end

  def get_column_number
    @column_num
  end

  def get_lexeme
    @line
  end

  def get_token_type
    @token_type
  end

end