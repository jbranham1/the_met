require 'minitest/pride'
require 'minitest/autorun'
require './lib/patron'

class PatronTest < Minitest::Test
  def test_it_exists
    patron = Patron.new("Bob", 20)

    assert_instance_of Patron, patron
  end
end
