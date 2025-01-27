require 'minitest/pride'
require 'minitest/autorun'
require './lib/patron'

class PatronTest < Minitest::Test
  def test_it_exists
    patron = Patron.new("Bob", 20)

    assert_instance_of Patron, patron
  end

  def test_it_has_readable_attributes
    patron = Patron.new("Bob", 20)

    assert_equal "Bob", patron.name
    assert_equal 20, patron.spending_money
    assert_equal [], patron.interests
  end

  def test_add_interest
    patron = Patron.new("Bob", 20)
    patron.add_interest("Dead Sea Scrolls")

    assert_equal ["Dead Sea Scrolls"], patron.interests
  end
end
