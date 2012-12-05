# ThreadVariable

[![Build Status](https://secure.travis-ci.org/amarshall/thread_variable.png)](http://travis-ci.org/amarshall/thread_variable)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/amarshall/thread_variable)

Makes it easy to create and use thread-local variables. This encapsulates two patterns:

- The `Thread.current` hash is not namespaced, which can make name collision between different libraries or parts of an app very possible. ThreadVariable gets around this by namespacing variables under the current class/module name.
- Accessing and setting `Thread.current` is not so pretty to look at, so ThreadVariable creates a getter and setter for each thread variable.

## Installation

Install as your normally would, nothing special here. Only compatible with Ruby 1.9+.

## Usage

Simply `extend ThreadVariable` and call `thread_variable` in classes you want thread variables in:

    class C
      extend ThreadVariable
      thread_variable :foo
    end

    C.foo = 'bar'

    Thread.new do
      C.foo = 'baz'
      C.foo  #=> "baz"
    end.join

    C.foo  #=> "bar"

If you don’t want to `extend ThreadVariable` everywhere you can instead do

    require 'thread_variable/core_ext'

which will `include ThreadVariable` in both `Class` & `Module`.

For more, just read the source. Seriously, go read it—it’s less than 20 lines and will only take a minute.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits & License

Copyright © 2012 J. Andrew Marshall. All rights reserved.
License is available in the LICENSE file.
