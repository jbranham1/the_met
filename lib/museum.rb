class Museum
  attr_reader :name,
              :exhibits,
              :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    @exhibits.select do |exhibit|
      patron.interests.any?(exhibit.name)
    end
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    @exhibits.each_with_object({}) do |exhibit, hash|
      hash[exhibit] = get_patrons_by_exhibit(exhibit)
    end
  end

  def get_patrons_by_exhibit(exhibit)
    @patrons.select do |patron|
      recommend_exhibits(patron).any?(exhibit)
    end
  end
end
