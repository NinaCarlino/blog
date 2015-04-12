---
title: "You're Going to Love MithrilJS"
date: 2015/04/04
author: Rick
published: false
---

MithrilJS is a relatively new MVC framework that takes the best aspects of Angular, React and Knockout into one light weight library. With its light 5kb file size, an impressive set of  benchmarks, a friendly API, and just the right amount of convention, we were thoroughly impressed.

### Easy to Learn

Coming from a background in AngularJS, we were impressed with how quick we were able to learn the Mithril API. Within one afternoon, we were writing functional apps. Mithril keeps magic and surprises to a minimum.

### Lightweight, not Stripped Down

Realisticly, every single page app you build is going to need support for things like routing, AJAX and promises. Luckily, MithrilJS comes with these by default and still manages to keep a light file size and a easy to learn API.

Take a look at how simple it is to create a data bound DOM element:

```javascript



```
### Secure by default

If you've ever worked with libraries like Backbone, you know that [XSS](--------) protection doesn't come by default. Mithril treats all strings as insecure by default and exposes an `m.trust()` method for the times you need to override the default.

### Plays Nicely with Coffeescript Features

We love coffeescript. With libraries like Angular and React, it's not always so simple to integrate. Because Mithril keeps magic to a minimum, we found very little issues in creating modesl and controllers using Coffeescript classes and comprehensions.

Here's an example of a model using a coffeescript class:

```coffeescript

class TodoItem
  constructor: (text = 'blank todo item') ->
    @text = m.prop(text)
```
When creating list components, we were able to leverage list comprehensions for a clean syntax:

```coffeescript

ListView = (controller) ->
  m "ul",
    m("li", item.text()) for item in controller.items

# Compiled output:
#  <ul>
#    <li>First Item</li>
#    <li>Second Item</li>
#  </ul>
```

Let's me leverage powerful features of coffeescript like classes (which is somewhat convoluted in ANgular). Doesn't complicate my build process like coffeescript + JSX. This is what happens when you have just the right amount of opinionation.

### Try it Out

CTA here.
