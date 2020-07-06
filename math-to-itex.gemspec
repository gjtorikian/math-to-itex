# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'math-to-itex/version'

Gem::Specification.new do |spec|
  spec.name          = 'math-to-itex'
  spec.version       = MathToItex::VERSION
  spec.authors       = ['Garen Torikian']
  spec.email         = ['gjtorikian@gmail.com']
  spec.summary       = 'Turn math syntaxes into itex equations.'
  spec.description   = 'Pass in a string and turn all math equations into itex equations. Or, pass in a block manipulate multiple matches.'
  spec.homepage      = 'https://github.com/gjtorikian/math-to-itex'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.0'

  spec.files = %w[LICENSE.txt README.md Rakefile math-to-itex.gemspec]
  spec.files += Dir.glob('lib/**/*')
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-standard'
  spec.add_development_dependency 'test-unit'
end
