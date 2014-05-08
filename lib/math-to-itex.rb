require "math-to-itex/parser"
require "math-to-itex/version"

module MathToItex
  refine String do
    def convert_to_itex(&block)
      self.gsub(MathToItex::Parser::REGEX) do |maths|
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
        elsif maths =~ /\A\\begin(?!\\begin)/
          just_maths = maths[16..-15]
          type = :display
        end

        # this is the format itex2MML expects
        if type == :inline
          just_maths = "$#{just_maths}$"
        else
          just_maths = "$$#{just_maths}$$"
        end

        next(just_maths) if block.nil?

        yield just_maths
      end
    end
  end
end
