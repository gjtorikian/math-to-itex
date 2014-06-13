require "test_helper"

class MathToItex::BasicTest < Test::Unit::TestCase
  def test_it_matches_single_dollar_signs
    result = MathToItex('$a \ne 0$').convert

    assert_equal '$a \ne 0$', result

    result = MathToItex('Here we go: $a \ne 0$').convert { |s| s }

    assert_equal 'Here we go: $a \ne 0$', result
  end

  def test_it_matches_paren_signs
    result = MathToItex('\(a \ne 0\)').convert

    assert_equal '$a \ne 0$', result

    result = MathToItex('Here we go: when $a \ne 0$, there are two solutions..').convert { |s| s }

    assert_equal 'Here we go: when $a \ne 0$, there are two solutions..', result
  end

  def test_it_matches_double_dollar_signs
    result = MathToItex('$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}$$').convert

    assert_equal '$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}$$', result

    result = MathToItex('Here we go: $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}$$').convert { |s| s }

    assert_equal 'Here we go: $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}$$', result
  end

  def test_it_matches_bracket_signs
    result = MathToItex('\[a \ne 0\]').convert

    assert_equal '$$a \ne 0$$', result

    result = MathToItex('Here we go: $$a \ne 0$$').convert { |s| s }

    assert_equal 'Here we go: $$a \ne 0$$', result
  end

  def test_it_matches_equation_notation
    result = MathToItex('\begin{equation}x = {-b \pm \sqrt{b^2-4ac} \over 2a}\end{equation}').convert

    assert_equal '$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}$$', result

    result = MathToItex('Here we go: \begin{equation}x = {-b \pm \sqrt{b^2-4ac} \over 2a}\end{equation}').convert { |s| s }

    assert_equal 'Here we go: $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}$$', result
  end

  def test_it_matches_multiple_lines
    text = '''
$$
\begin{array}[t]{clrc}
  1 & 2 & 3 & 4 \\\\
  5 & 6 & 7 & 8
\end{array}
$$
'''
    result = MathToItex(text).convert { |string| string.sub(/2/, '9') }

    assert_match '9', result
    assert_no_match /2/, result
  end

  def test_it_manipulates_strings
    result = MathToItex('\[a \ne 0\]').convert { |string| string.sub(/ne/, 'eq') }
    assert_equal '$$a \eq 0$$', result

    result = MathToItex('ne \[a \ne 0\]').convert { |string| string.sub(/ne/, 'eq') }
    assert_equal 'ne $$a \eq 0$$', result
  end

  def test_it_can_get_type
    result = MathToItex('$0$ is not equal to $$1 = 0$$').convert do |string, type|
      %|<span class="#{type}">#{string}</span>|
    end

    assert_equal '<span class="inline">$0$</span> is not equal to <span class="display">$$1 = 0$$</span>', result
  end
end
