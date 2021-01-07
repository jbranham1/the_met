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

  def test_patrons_by_exhibit_interest
    dead_sea_scrolls = mock
    gems_and_minerals = mock
    dead_sea_scrolls.stubs(:name).returns("Dead Sea Scrolls")
    gems_and_minerals.stubs(:name).returns("Gems and Minerals")
    @dmns.add_exhibit(@imax)
    @dmns.add_exhibit(dead_sea_scrolls)
    @dmns.add_exhibit(gems_and_minerals)

    patrons_hash = {
      dead_sea_scrolls => [],
      gems_and_minerals => [],
      @imax => []
    }
    assert_equal patrons_hash, @dmns.patrons_by_exhibit_interest
  end
end
