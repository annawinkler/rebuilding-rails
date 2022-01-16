require_relative 'test_helper'

class UtilTest < Minitest::Test
  def test_to_underscore
    assert_equal 'try_any_words', Rulers.to_underscore('TryAnyWords')
  end
end