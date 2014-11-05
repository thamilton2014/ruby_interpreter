class Feature

  attr_accessor :compound

  def initialize(compound)
    if compound.nil?
      raise TypeError, '[Feature] compound is null'
    end
    @compound = compound
  end

  def execute
    @compound.execute
  end

end