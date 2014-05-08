require "test_helper"

class MathToItex::BasicTest < Test::Unit::TestCase
  using MathToItex

  def test_it_matches_single_dollar_signs
    result = '$a \ne 0$'.convert_to_itex

    assert_equal '$a \ne 0$', result

    result = 'Here we go: $a \ne 0$'.convert_to_itex { |s| s }

    assert_equal 'Here we go: $a \ne 0$', result
  end

  def test_it_matches_paren_signs
    result = '\(a \ne 0\)'.convert_to_itex

    assert_equal '$a \ne 0$', result

    result = 'Here we go: when $a \ne 0$, there are two solutions..'.convert_to_itex { |s| s }

    assert_equal 'Here we go: when $a \ne 0$, there are two solutions..', result
  end

  def test_it_matches_double_dollar_signs
    result = '$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}$$'.convert_to_itex

    assert_equal '$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}$$', result

    result = 'Here we go: $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}$$'.convert_to_itex { |s| s }

    assert_equal 'Here we go: $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}$$', result
  end

  def test_it_matches_bracket_signs
    result = '\[a \ne 0\]'.convert_to_itex

    assert_equal '$$a \ne 0$$', result

    result = 'Here we go: $$a \ne 0$$'.convert_to_itex { |s| s }

    assert_equal 'Here we go: $$a \ne 0$$', result
  end

  def test_it_matches_equation_notation
    result = '\begin{equation}x = {-b \pm \sqrt{b^2-4ac} \over 2a}\end{equation}'.convert_to_itex

    assert_equal '$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}$$', result

    result = 'Here we go: \begin{equation}x = {-b \pm \sqrt{b^2-4ac} \over 2a}\end{equation}'.convert_to_itex { |s| s }

    assert_equal 'Here we go: $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}$$', result
  end

  def test_it_manipulates_strings
    result = '\[a \ne 0\]'.convert_to_itex { |string| string.sub(/ne/, 'eq') }
    assert_equal '$$a \eq 0$$', result

    result = 'ne \[a \ne 0\]'.convert_to_itex { |string| string.sub(/ne/, 'eq') }
    assert_equal 'ne $$a \eq 0$$', result
  end
end
