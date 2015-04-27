---
title: Writing Ruby Square Bracket Methods
date: 2015/03/26
author: Rick
tags:
featured_image: ruby.png
---

One thing that many early Rubyists fail to realize about square brackets (`[]`) in Ruby is that they are nothing more than a method with some added syntactic sugar. Everything is an object in Ruby, and square brackets are just a method call on those objects.

The language has given `[]` a special syntax, but everything is an object at the end of the day.

Take a look at this example:

```ruby

array = [1, 'two', :three]

# array[1] is just syntactic sugar for this...
array.send(:[], 1) # => 'two'

# ...Even this nonsense will work (don't do this at home, kids):
array.[](1) # => 'two'
```

It also works for setting array elements with a similar method, `[]=`:

```ruby

array = [1, 'two', :three]

# Add "FOUR" to index 3
array.send(:[]=, 3, "FOUR") # => "FOUR"

# This is syntactically valid, but may make you unpopular with other developers:
array.[]=(0, 'zero') # => "zero"

array # => ["zero", "two", :three, "FOUR"]

```

Taking this realization one step further you will realize that a class doesn't need to be an Array or Hash descendant to take advantage of the square bracket syntax.

Let's build a simple object to illustrate the possibilities:

```ruby

class FakeCollection
  attr_reader :items

  def initialize
    @items = {}
  end

  def [](index)
    @items[index] || "Not Found"
  end

  def []=(index, value)
    @items[index] = value
  end
end

example = FakeCollection.new

example[:x] = "Hello, world"

example[:x]
# => "Hello, world"

```

The syntax for defining these methods may be surprising, but it can be a great way to encapsulate logic with a familiar interface. The next time you find yourself needing to express collection lookups on your objects, consider using square brackets.
