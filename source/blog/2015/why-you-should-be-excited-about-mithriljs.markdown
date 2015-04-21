---
title: "Why You're Going to Love MithrilJS"
date: 2015/04/04
author: Rick
published: true
---

 > I started using MithrilJS this month and it has impressed me more than any front end library ever has. Despite being a happy Angular developer for quite some time, I've ocassionally found myself hoping for a more simple solution. On the opposite side of the spectrum, I've felt that lighter weight options like React were too stripped down out of the box.

Somewhere in the middle, I found Mithril. Mithril hit a perfect balance between simplicity and utility. It brings many of the best elements of Angular and React to the table.

Mithril has a light file size (5kb), an impressive set of benchmarks, a friendly API, and just the right amount of convention.

I'm excited for the future of this library. Here's an overview of what made it worthwhile to me.

### Easy to Learn

As an Angular developer, I was impressed with how quickly I could learn the Mithril API. In one afternoon, I was writing apps. Mithril kept the magic to a minimum. Don't believe me? Take a look at the mere [1000 lines of source code on GitHub](https://github.com/lhorie/mithril.js/blob/next/mithril.js). For me, that's a huge win both for debugging and maintenance.

### Lightweight, Not Stripped Down

The vast majority of single page apps need to support URL routing, AJAX and promises. Luckily, MithrilJS comes with these by default and still manages to keep a light file size and easy-to-learn API. Having these tools as part of the mainline repository rather than as third party libraries also means there is a larger pool of community support when issues do arise.

 * [URL Router](https://lhorie.github.io/mithril/routing.html)
 * [AJAX Adapter](https://lhorie.github.io/mithril/mithril.request.html#basic-usage)
 * Deffered / Promise support: [1](https://lhorie.github.io/mithril/mithril.deferred.html), [2](https://lhorie.github.io/mithril/mithril.sync.html)

When the defaults aren't enough, the community has done a great job of maintaining a [curated list](https://github.com/lhorie/mithril.js/wiki/Community-Projects-and-Snippets) of third party tools.

### Plays Nicely with Coffeescript and Compile-To-JS

Because Mithril has a unicorn-free API that is "Just Javascript(tm)", we found no issues when creating models and controllers using Coffeescript classes and comprehensions.

```coffeescript

# Two line Mithril model using coffeescript classes and m.prop():

class TodoItem
  constructor: (@text = m.prop(text)) ->

```

When creating list components, we were also able to leverage list comprehensions for a clean syntax:

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

### The Future is Bright

The Mithril community continues to move this project in the right direction and I hope that more developers give it a look when comparing their options on the frontend. Consider giving it a try for your next project. You won't be disappointed.
