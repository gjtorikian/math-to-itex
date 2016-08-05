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

  def test_it_does_nothing_on_strings_with_some_dollars
    result = MathToItex('I bought a sandwich for $5 but it was only worth $3.').convert { |string| string.upcase }

    assert_equal result, "I bought a sandwich for $5 but it was only worth $3."
  end

  def test_it_does_nothing_on_strings_with_some_double_dollars
    result = MathToItex('I went to that restaurant that was marked as $$ but it turned out to actually be $$$ so now I\'m a little strapped.').convert { |string| string.upcase }

    assert_equal result, "I went to that restaurant that was marked as $$ but it turned out to actually be $$$ so now I'm a little strapped."
  end
end
