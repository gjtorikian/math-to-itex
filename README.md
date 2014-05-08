# Math to Itex

Convert strings into a proper [itex](http://golem.ph.utexas.edu/~distler/blog/itex2MML.html) format.

[![Build Status](https://travis-ci.org/gjtorikian/math-to-itex.svg?branch=master)](https://travis-ci.org/gjtorikian/math-to-itex)

## Installation

Add this line to your application's Gemfile:

    gem 'math-to-itex'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install math-to-itex

## Usage

Due to fancy regexes, this gem only works with Ruby 2.0+.

To use this gem, pass a string to the `MathToItex` module, and an optional block:

``` ruby
require 'math-to-itex'

result = MathToItex('\[a \ne 0\]').convert
# result is now `$$a \ne 0$$`

result = MathToItex('\[a \ne 0\]').convert { |string| "<span>#{string}</span>" }
# result is now `<span>$$a \ne 0$$</span>`
```

Basically, by not passing a block, you do a simple convert. By passing a block,
you can modify the resulting math equation.

Behind the scenes, `MathToItex` uses `gsub`, so *all* equations in a string are
modified.

If you want, you can determine the type (inline or display), too:

``` ruby
result = MathToItex('$0$ is not equal to $$1 = 0$$').convert do |string, type|
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

## More math stuff

Check out [Mathematical](https://github.com/gjtorikian/mathematical), which quickly
converts itex notation equations into beautiful SVGs.
