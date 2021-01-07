require 'minitest/pride'
require 'minitest/autorun'
require './lib/museum'
require './lib/exhibit'
require './lib/patron'
require 'mocha/minitest'

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
    imax = mock

    dmns.add_exhibit(imax)

    assert_equal [imax], dmns.exhibits
  end

  def test_recommend_exhibits
    dmns = Museum.new("Denver Museum of Nature and Science")
    imax = mock
    dead_sea_scrolls = mock
    gems_and_minerals = mock
    dead_sea_scrolls.stubs(:name).returns("Dead Sea Scrolls")
    gems_and_minerals.stubs(:name).returns("Gems and Minerals")
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(gems_and_minerals)
    patron = mock
    patron.stubs(:interests).returns(["Dead Sea Scrolls","Gems and Minerals"])

    recommended_exhibits = [dead_sea_scrolls, gems_and_minerals]

    assert_equal recommended_exhibits, dmns.recommend_exhibits(patron)
  end
end
