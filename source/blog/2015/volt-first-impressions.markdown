---
title: "Volt: First Impressions"
date: 2015/04/28
author: Rick
tags: Ruby, Volt
published: false
featured_image: volt.png
---

The Ruby community has seen a recent surge in interest for the [Volt Realtime web frontend framework](http://voltframework.com/). I gave it a spin this month and was surprised with the results, particularly for its focus on developer productivity.

The Volt framework is a relative newcomer to the Ruby ecosystem and it embodies the same ethos as Rails- fast development work flows that don't compromise productivity. Unlike Rails, it places its core emphasis on real-time application development.

I'm excited about Volt because it is the first framework to offer a productive, full-stack work flow for Rubyists developing realtime apps. It's also the most popular framework to utilize OpalRB- a Ruby-to-Javascript compiler for use in the browser.

<!-- ## The Complexity Recession is Coming

The advent of AJAX caused a bull market for web development complexity. As our use of AJAX increased, technologies such as front end MVC came about to bring order to the chaso. In doing so, we have increased the level of complexity to the point that we must define routes, models and certain other behavior In his talk at Railsconf, Ryan Stout talked about. . .
## Adapting to the Workflow
 -->

## The Opal Compiler: Ruby Everywhere

In my first 10 minutes with Volt, I was amazed to find a `puts` statement in a controller action appeared not in my terminal console, but in my browser window. That's because Volt applications run Ruby on the frontend and the backend. Writing realtime Ruby code for the front end with Volt was so easy I didn't even realize I was doing it.

There were no complicated compilation step to follow. No build tool to install. I ran `volt server` and everything took place transparently in the background. Changes to my code or data happened instantaneously- no refresh or restart.

In Volt, Javascript usage is minimized and Ruby code is shared by the server and the browser. This is accomplished via use of the [Opal Compiler](http://opalrb.org/docs/compiled_ruby/). I was originally skeptical of how productive I would be running anything other than Javascript on the frontend, but was surprised by the simplicity.

EXHIBIT A: Calling a javascript alert with Ruby

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

This was the most important concept when learning volt. `Volt::Model` (and its counter part, `Volt::ArrayModel`) act as hash-like Ruby objects that sync between the front end and back end simultaneously. Updates to the model propagate automatically in most cases. Think of them as variabls that live in limbo between the frontend and backend.

Volt offers the concept of "stores" to sync application data in a variety of forms- persistent and non-persistent. It provides a uniform means of syncing data between local storage, MongoDB, cookies, sessions and URL params. More databases are planned for future releases.

Let's make a realtime chat app in a few lines of Ruby and HTML:

```ruby
# Create a persistent data model. This gets stored in MongoDB.
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
Here's a GIF screencast of the update events rendering in realtime:

![Realtime Updates](/images/blog/2015/volt-animation.gif)

## The Best is Yet to Come

The project is less than 2 years old and has already made huge strides forward. It feels a lot like the early days of Rails- solving huge problems in a short amount of time and with great promise ahead.

I hope this post motivates you to take the plunge and try Volt for yourself. Stay tuned for future posts where I dive deeper and cover basic use cases. Have a specific question for a future post? Submit a comment or drop a line on [Twitter](https://twitter.com/datamelon) or [Reddit](https://www.reddit.com/user/rickcarlino).
