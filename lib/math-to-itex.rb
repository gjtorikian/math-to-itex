require "math-to-itex/parser"
require "math-to-itex/support_parens"
require "math-to-itex/version"

module MathToItex

  def self.parens(string)
    @string = string
    self
  end

  def self.convert(&block)
    @string.gsub(MathToItex::Parser::REGEX) do |maths|
      if maths =~ /\A\$(?!\$)/
        just_maths = maths[1..-2]
        type = :inline
      elsif maths =~ /^\\\((?!\\\()/
        just_maths = maths[2..-3]
        type = :inline
      elsif maths =~ /\A\$\$/
        just_maths = maths[2..-3]
        type = :display
      elsif maths =~ /\A\\\[(?!\\\[)/
        just_maths = maths[2..-3]
        type = :display
      elsif maths =~ /\A\\begin{equation}(?!\\begin{equation})/
        just_maths = maths[16..-15]
        type = :display
      elsif maths =~ /\A\\begin{math}(?!\\begin{math})/
        just_maths = maths[12..-11]
        type = :inline
      elsif maths =~ /\A\\begin{displaymath}(?!\\begin{displaymath})/
        just_maths = maths[19..-18]
        type = :display
      end

      # this is the format itex2MML expects
      if type == :inline
        all_maths = "$#{just_maths}$"
      else
        all_maths = "$$#{just_maths}$$"
      end

      next(all_maths) if block.nil?

      yield all_maths, type, just_maths
    end
  end
end
