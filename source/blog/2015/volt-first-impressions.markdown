---
title: "Volt: First Impressions"
date: 2015/04/28
author: Rick
tags: Ruby, Volt
published: false
featured_image: volt.png
---

 > In my first 10 minutes with Volt, I was amazed to find a `puts` statement in a controller action appear not in my terminal console, but in my browser window. Writing Ruby code for the front end with Volt was so easy I didn't even realize I was doing it.

There were no complicated compilation step to follow. No build tool to install. I ran `volt server` and everything took place transparently in the background. Changes to my code or data happened instantaneously- no refresh or restart.

Ruby on Rails has been a go-to resource in web development for the past 10 years because it offers developers a way to build sites fast while preserving developer happiness.

The Volt framework is a relative newcomer to the Ruby ecosystem and it embodies the same ethos as Rails- fast development work flows that don't compromise productivity. Unlike Rails, it places its core emphasis on real-time application development.

I'm excited about Volt because it is the first framework to offer a productive, full-stack work flow for Rubyists developing realtime apps. It's also the most popular framework to utilize OpalRB- a Ruby-to-Javascript compiler for use in the browser.

## Adapting to the Workflow

Learning Volt from a Rails perspective meant there were new concepts to learn, but it was a relatively smooth transition.

Experienced Rails users should have no problem adapting to the framework after learning a few key concepts.

## The Opal Compiler: Ruby Everywhere

In Volt, Javascript usage is minimized and Ruby code is shared by the server and the browser. This is accomplished via use of the [Opal Compiler](http://opalrb.org/docs/compiled_ruby/). I was originally skeptical of how productive I would be running anything other than Javascript on the frontend, but was surprised by the simplicity.

Here's an example of Ruby running as Javascript in a controller action:

```ruby
# Calling javascript functions in Ruby
module Main
  class MainController < Volt::ModelController
    # Called from front end when "todos" route loads.
    def todos
      alert 'totes amaze'
    end
  end
end
```

![Isomorphic Ruby](/images/blog/2015/volt-totes-amaze.png)

## Easy Syncing via Reactive Models

This was the most important concept when learning volt. `Volt::Model` (and its counter part, `Volt::ArrayModel`) act as hash-like Ruby objects that sync between the front end and back end simultaneously. Updates to the model propagate automatically in most cases.

Volt offers the concept of "stores" to sync application data in a variety of forms- persistent and non-persistent. It provides a uniform means of syncing data between local storage, MongoDB, cookies, and sessions. More databases are planned for future releases.

Let's make a realtime chat app in a few line of Ruby and HTML:

```ruby
# Create a persistent data model.
class ChatMessage < Volt::Model
end
```
Here's the view code:

```html
<:Body>
  <form e-submit="say">
    <input class="form-control" type="text" value="{{ page._input }}" />
  </form>
  <ul>
    {{ _chat_messages.reverse_each do |msg| }}
      <ul><button e-click="msg.destroy">X</button>{{ msg._text }}</ul>
    {{ end }}
  </ul>
```
Here's a GIF of the update events rendering in realtime:

![Realtime Updates](/images/blog/2015/volt-animation.gif)


## More Features Coming

After taking the time to learn Volt, I can see not only the benefits, but the implications that this will have for the future of Ruby. What makes Volt special is that it is committed to productivity, code reuse and an API that feels natural for Rubyists. The project is less than 2 years old and already it has made huge strides.

Stay tuned for future posts where I dive deeper into the specifics and cover basic use cases.
