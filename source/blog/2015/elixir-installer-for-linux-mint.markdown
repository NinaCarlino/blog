---
title: Elixir Installer For Linux Mint 17
date: 2015/04/23
author: Jason
tags: Elixir, Installation, Linux Mint
published: true
featured_image: elixir.png
---

For a while now I've been pushing/harassing Rick to learn and adopt [Elixir](http://elixir-lang.org).

I've been using Elixir for a few months and I find coding in Elixir to be a truely enjoyable experience. I've tried convincing Rick that Elixir is [worth learning](http://www.creativedeletion.com/2015/04/19/elixir_next_language.html) and [only getting better](https://www.youtube.com/watch?v=Lqo9-pQuRKE&feature=youtu.be&t=2009).

Both Rick and I are avid users of Linux Mint. After experiencing some issues with the [Elixir-lang.org installation instructions](http://elixir-lang.org/install.html) I decided to write a script that could be used to install Elixir in one step.

Using the new script is easy. [Click here to visit the repo](https://github.com/DataMelon/install-elixir-1.0.4) or follow these instructions.

Note: this script is for initial installation of Elixir and not for upgrading from 1.0.3 to 1.0.4. This script does not remove anything from the machine it runs on, but may override older installations of Erlang. Use with caution.

#### Installation

Make sure when you clone this repo that the files will persist (not a tmp/ dir).

In bash:

1. ```git clone https://github.com/DataMelon/install-elixir-1.0.4.git```
1. ```cd install-elixir-1.0.4.git```
1. ```chmod u+x install_erlang_and_elixir.sh```
1. ```sudo ./install_erlang_and_elixir.sh```
1. Logout and Log in.

#### Conclusion

That's all for now. Enjoy building amazing software with Elixir.






