class Memory

  MAP = {:a => 0, :b => 0, :c => 0, :d => 0, :e => 0, :f => 0, :g => 0,
         :h => 0, :i => 0, :j => 0, :k => 0, :l => 0, :m => 0, :n => 0,
         :p => 0, :q => 0, :r => 0, :s => 0, :t => 0, :u => 0, :v => 0,
         :w => 0, :x => 0, :y => 0, :z => 0}

  def initialize

  end

  def fetch(character)
    if character.nil?
      raise TypeError, '[Memory] character is null'
    end
    MAP["#{character}"]

    # hash[character.to_sym]
  end

  def store(index, param)
    if index.nil?
      raise TypeError, '[Memory] index is null'
    end
    if param.nil?
      raise TypeError, '[Memory] param is null'
    end
    MAP["#{index}"] = param
  end

  def display_memory
    puts MAP
  end

end