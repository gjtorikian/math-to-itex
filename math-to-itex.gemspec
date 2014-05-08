# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'math-to-itex/version'

Gem::Specification.new do |spec|
  spec.name          = "math-to-itex"
  spec.version       = MathToItex::VERSION
  spec.authors       = ["Garen Torikian"]
  spec.email         = ["gjtorikian@gmail.com"]
  spec.summary       = %q{Turn math syntax into itex equations.}
  spec.description   = %q{Pass in a string and turn it into an itex equation. Or, pass in a chunk of text and a block to iterate over multiple matches.}
  spec.homepage      = "https://github.com/gjtorikian/math-to-itex"
  spec.license       = "MIT"

  spec.files         = %w(LICENSE.txt README.md Rakefile math-to-itex.gemspec)
  spec.files         += Dir.glob("lib/**/*")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
end
