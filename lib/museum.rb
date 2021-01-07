class Museum
  attr_reader :name,
              :exhibits

  def initialize(name)
    @name = name
    @exhibits = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    @exhibits.select do |exhibit|
      patron.interests.any?(exhibit.name)
    end
  end

  def patrons_by_exhibit_interest
  end
end
