require 'minitest/pride'
require 'minitest/autorun'
require './lib/museum'
require './lib/exhibit'

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
end
