require "test_helper"

class MathToItex::BasicTest < Test::Unit::TestCase
  def test_it_does_not_work_without_inclusion
    assert_raise NoMethodError do
      '$a \ne 0$'.convert_to_itex
    end
  end

  using MathToItex

  def test_it_does_not_error_on_nested_commands
    result = '$$ a \ne \text{foo $\Gamma$ bar} b$$'.convert_to_itex { |string| string }

    assert_equal result, '$$ a \ne \text{foo $\Gamma$ bar} b$$'
  end

  def test_it_does_nothing_on_non_itex_strings
    result = 'Well, hello there.'.convert_to_itex { |string| string.upcase }

    assert_equal result, "Well, hello there."
  end
end
