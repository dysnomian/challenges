# Challenges

## The Challenges

### Ruby Metaprogramming

*Your challenge, should you accept it, is to write a Ruby library that will
modify an existing program to output the number of times a specific method is
called.*

You solution library should be required at the top of the host program, or via
ruby's -r flag (i.e. `ruby -r ./solution.rb host_program.rb`).

Your solution library should read the environment variable `COUNT_CALLS_TO` to
determine the method it should count. Valid method signatures are `Array#map!`,
`ActiveRecord::Base#find`, `Base64.encode64`, etc.

Your solution library should count calls to that method, and print the method
signature and the number of times it was called when the program exits.

Also, your solution should have a minimal impact on the program's running time.
`set_trace_func` is a no-go...

As an example, here's a valid solution being called with a one line program to
count String#size calls:

    COUNT_CALLS_TO='String#size' ruby -r ./solution.rb -e '(1..100).each{|i|
    i.to_s.size if i.odd? }' String#size called 50 times

Here's another more complex example:

    COUNT_CALLS_TO='B#foo' ruby -r ./solution.rb -e 'module A; def foo; end;
    end; class B; include A; end; 10.times{B.new.foo}' B#foo called 10 times

## Installation

Add this line to your application's Gemfile:

```ruby gem 'challenges' ```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install challenges

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/[USERNAME]/challenges.

