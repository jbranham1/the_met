require 'minitest/pride'
require 'minitest/autorun'
require './lib/museum'
require './lib/exhibit'
require './lib/patron'

class MuseumTest < Minitest::Test
  def test_it_exists
    dmns = Museum.new("Denver Museum of Nature and Science")

    assert_instance_of Museum, dmns
  end

  def test_it_has_readable_attributes
    dmns = Museum.new("Denver Museum of Nature and Science")

    assert_equal "Denver Museum of Nature and Science", dmns.name
    assert_equal [], dmns.exhibits
  end

  def test_add_exhibit
    dmns = Museum.new("Denver Museum of Nature and Science")
    imax = Exhibit.new({name: "IMAX",cost: 15})

    dmns.add_exhibit(imax)

    assert_equal [imax], dmns.exhibits
  end

  def test_recommend_exhibits
    dmns = Museum.new("Denver Museum of Nature and Science")
    imax = Exhibit.new({name: "IMAX",cost: 15})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(gems_and_minerals)
    patron_1 = Patron.new("Bob", 20)
    patron_1.add_interest("Dead Sea Scrolls")
    patron_1.add_interest("Gems and Minerals")
    recommended_exhibits = [dead_sea_scrolls, gems_and_minerals]

    assert_equal recommended_exhibits, dmns.recommend_exhibits(patron_1)
  end
end
