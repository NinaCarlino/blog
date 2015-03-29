---
title: "MeshRuby: New MeshBlu Adapter for Ruby"
date: 2015/03/24
author: Rick
tags:
---

We are happy to announce the release of our own third party [MeshBlu](https://developer.octoblu.com/) adapter for Ruby: [MeshRuby](https://github.com/DataMelon/MeshRuby).

[MeshBlu](https://developer.octoblu.com/) is an open source Internet-of-Things messaging gateway managed by [OctoBlu](http://octoblu.com/). It's a joy to work with and has been a great help on our IoT projects.

Setup is a snap, especially if you are already familiar with [EventMachine](https://github.com/eventmachine/eventmachine).

Here's an example of an echo server that routes traffic over MeshBlu:

```ruby

uid   = '11111111-1111-1111-1111-111111111111'
token = '22222222222222222222222222222222'

EM.run do
  mesh = EM::MeshRuby.new(uid, token).connect

  # Messages come in as Ruby hashes when possible
  # If the message is unparsable, it will return strings
  mesh.onmessage { |msg| mesh.emit(msg["fromUuid"], {echoMsg: msg}) }

  # Send messages by calling `emit()`
  elvis = '00000000-0000-0000-0000-000000000000'
  mesh.emit(elvis, {you_said: msg})
end
```

At the time of this writing, MeshRuby is the only native Ruby wrapper available for MeshBlu (that we are aware of).

We hope you give MeshRuby a try and help us support continued development by raising an issue or submitting a pull request on [Github](https://github.com/DataMelon/MeshRuby).
