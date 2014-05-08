require "test_helper"

class MathToItex::BasicTest < Test::Unit::TestCase
  def test_it_does_not_error_on_nested_commands
    result = MathToItex('$$ a \ne \text{foo $\Gamma$ bar} b$$').convert { |string| string }

    assert_equal result, '$$ a \ne \text{foo $\Gamma$ bar} b$$'
  end

  def test_it_does_nothing_on_non_itex_strings
    result = MathToItex('Well, hello there.').convert { |string| string.upcase }

    assert_equal result, "Well, hello there."
  end
end
