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

  def ticket_lottery_contestants(exhibit)
    get_patrons_by_exhibit(exhibit).select do |patron|
      patron.spending_money < exhibit.cost
    end
  end

  def draw_lottery_winner(exhibit)
    string = get_names(exhibit)
    if string.empty?
      nil
    else
      "#{string} can be returned here. Fun!"
    end
  end

  def get_names(exhibit)
    names = ticket_lottery_contestants(exhibit).map do |patron|
      patron.name
    end.flatten
    string = names.join(" or ")
  end
end
