require 'minitest/pride'
require 'minitest/autorun'
require './lib/museum'
require './lib/exhibit'
require './lib/patron'
require 'mocha/minitest'

class MuseumTest < Minitest::Test
  def setup
    @dmns = Museum.new("Denver Museum of Nature and Science")
    @imax = mock

    @patron = mock
    @patron.stubs(:interests).returns(["Dead Sea Scrolls","Gems and Minerals"])
  end

  def test_it_exists
    assert_instance_of Museum, @dmns
  end

  def test_it_has_readable_attributes
    assert_equal "Denver Museum of Nature and Science", @dmns.name
    assert_equal [], @dmns.exhibits
  end

  def test_add_exhibit
    @dmns.add_exhibit(@imax)

    assert_equal [@imax], @dmns.exhibits
  end

  def test_recommend_exhibits
    dead_sea_scrolls = mock
    gems_and_minerals = mock
    dead_sea_scrolls.stubs(:name).returns("Dead Sea Scrolls")
    gems_and_minerals.stubs(:name).returns("Gems and Minerals")
    @dmns.add_exhibit(dead_sea_scrolls)
    @dmns.add_exhibit(gems_and_minerals)
    recommended_exhibits = [dead_sea_scrolls, gems_and_minerals]

    assert_equal recommended_exhibits, @dmns.recommend_exhibits(@patron)
  end

  def test_admit
    @dmns.admit(@patron)

    assert_equal [@patron], @dmns.patrons
  end

  def test_patrons_by_exhibit_interest
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    patron_1 = Patron.new("Bob", 20)
    patron_1.add_interest("Dead Sea Scrolls")
    patron_1.add_interest("Gems and Minerals")
    patron_2 = Patron.new("Sally", 20)
    patron_2.add_interest("Gems and Minerals")
    dmns.admit(patron_1)
    dmns.admit(patron_2)

    patrons_hash = {
      gems_and_minerals => [patron_1, patron_2],
      dead_sea_scrolls => [patron_1]
    }
    assert_equal patrons_hash, dmns.patrons_by_exhibit_interest
  end

  def test_ticket_lottery_contestants
    dmns = Museum.new("Denver Museum of Nature and Science")
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    dmns.add_exhibit(dead_sea_scrolls)
    patron_1 = Patron.new("Bob", 20)
    patron_1.add_interest("Dead Sea Scrolls")
    patron_2 = Patron.new("Sally", 5)
    patron_2.add_interest("Dead Sea Scrolls")
    dmns.admit(patron_1)
    dmns.admit(patron_2)

    assert_equal [patron_2], dmns.ticket_lottery_contestants(dead_sea_scrolls)
  end

  def test_draw_lottery_winner
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    patron_1 = Patron.new("Bob", 20)
    patron_1.add_interest("Dead Sea Scrolls")
    patron_2 = Patron.new("Sally", 5)
    patron_2.add_interest("Dead Sea Scrolls")
    patron_3 = Patron.new("Johnny", 5)
    patron_3.add_interest("Dead Sea Scrolls")
    dmns.admit(patron_1)
    dmns.admit(patron_2)
    dmns.admit(patron_3)

    return_string = "Sally or Johnny can be returned here. Fun!"
    assert_equal return_string, dmns.draw_lottery_winner(dead_sea_scrolls)
    assert_nil dmns.draw_lottery_winner(gems_and_minerals)
  end
end
