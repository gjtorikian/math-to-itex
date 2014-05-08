# Math to Itex

Convert strings into a proper [itex](http://golem.ph.utexas.edu/~distler/blog/itex2MML.html) format.

## Installation

Add this line to your application's Gemfile:

    gem 'math-to-itex'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install math-to-itex

## Usage

This gem depends on [refinements](http://blog.headius.com/2012/11/refining-ruby.html), which is a Ruby 2.1+ feature. To use it:

``` ruby
require 'math-to-itex'
using MathToItex

result = '\[a \ne 0\]'.convert_to_itex
# result is now `$$a \ne 0$$`

result = '\[a \ne 0\]'.convert_to_itex { |string| "<span>#{string}</span>" }
# result is now `<span>$$a \ne 0$$</span>`
```

Basically, by not passing a block, you do a simple convert. By passing a block,
you can modify the resulting math equation.

Behind the scenes, `MathToItex` uses `gsub`, so *all* equations in a string are
modified.

If you want, you can determine the type (inline or display), too:

``` ruby
result = '$0$ is not equal to $$1 = 0$$'.convert_to_itex do |string, type|
  %|<span class="#{type}">#{string}</span>|
end

# result is `<span class="inline">$0$</span> is not equal to <span class="display">$$1 = 0$$</span>`
```

## Matched math notations

Currently, the following formats are supported:

| inline formulas | display formulas |
| ------------- |-------------|
| `$...$`      | `$$...$$`
| `(...)`      | `[...]`
| &nbsp;      | `\begin{equation}...\end{equation}`
