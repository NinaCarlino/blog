---
title: Exploring HTTP with Raw TCP Sockets and Ruby
date: 2015/04/24
author: Rick
tags: ruby
published: false
---

An aspiring Ruby learner recently asked us an interesting question:

 > How the heck do HTTP requests work, anyway?

Good question. There are plenty of tools out there for serving and requesting HTTP documents in Ruby such as [the standard library HTTP class](http://ruby-doc.org/stdlib-2.2.2/libdoc/net/http/rdoc/Net/HTTP.html), a [slew of 3rd party HTTP clients](https://www.ruby-toolbox.com/categories/http_clients). If you want to serve the documents, you have options such as [Sinatra](http://www.sinatrarb.com/) and everyone's default choice: [Ruby on Rails].

They're great tools because they abstract away all the low level details. Today, we will forgo the niceties of such libraries and write an HTTP request using the Ruby standard library and raw TCP sockets.

## Reinventing the Wheel: an (Oversimplified) CURL client

As an example, I built a simple Ruby script that functions similarly to [CURL](https://en.wikipedia.org/wiki/CURL).

Here's the finished product:

```ruby

require 'socket'
require 'uri'

print "Enter a domain: (default is 'datamelon.io'):"

input = gets.chomp
url = URI.parse("http://#{input.empty? ? 'datamelon.io' : input}/")
puts "Downloading #{url.to_s} =="

connection = TCPSocket.new url.host, 80
connection.puts "GET / HTTP/1.1"
connection.puts "Host: #{url.host}"
connection.puts "Connection: close" # Tell server to close connection when done.
connection.puts "\n"                # Empty line to indicate end of request.

while line = connection.gets
  puts line # Print the response data until we run out of text.
end

puts "Done downloading #{url.to_s}"
connection.close

```

If you run this script, you will get the following output:

```
$ ruby ruby-curl.rb

Enter a domain: (default is 'datamelon.io'):

Downloading http://datamelon.io/ ==
HTTP/1.1 200 OK
Server: nginx/1.2.1
Date: Fri, 24 Apr 2015 16:49:01 GMT
Content-Type: text/html
Content-Length: 10261
Last-Modified: Sun, 12 Apr 2015 17:23:46 GMT
Connection: close
Accept-Ranges: bytes

<!DOCTYPE html>
<html>
  <head>
    <title>
      DataMelon
    </title>
. . .
  . . .
```

Look at that! An unparsed HTML document. **How did that happen?**

## The Socket / URI libraries

The first thing we did was `require` the TCP and URI Ruby libraries. Being a "batteries included" language means that Ruby comes with these tools by default. The URI parser is useful for avoiding excessive string manipulation and provides tools for easy extraction of information from URLs.

```ruby

require 'socket'
require 'uri'
``

Now that we've loaded everything we need, we grab user input and open a TCP socket.

```ruby
print "Enter a domain: (default is 'datamelon.io'):"

input = gets.chomp
url = URI.parse("http://#{input.empty? ? 'datamelon.io' : input}/")
puts "Downloading #{url.to_s} =="

connection = TCPSocket.new url.host, 80
```

## TCPSocket and IO Objects

The [IO Class](http://ruby-doc.org/core-2.2.2/IO.html) is the basis for all IO in Ruby. In the case of TCP sockets, it provides us with a bidirectional data stream over a network. The majority of network applications send data over TCP sockets. [UDP Sockets](http://ruby-doc.org/stdlib-1.9.3/libdoc/socket/rdoc/UDPSocket.html) are a similar alternative.

The use of `gets` and `puts` allow the socket to act like other `IO` objects in Ruby, such as the keyboard or screen (`STDOUT`, `STDIN`).

```ruby

connection = TCPSocket.new url.host, 80
connection.puts "GET / HTTP/1.1"
connection.puts "Host: #{url.host}" # The Host we're looking for.
connection.puts "Connection: close" # Tell server to close connection when done.
connection.puts "\n"                # Empty line to indicate end of request.
```

We just sent 3 things upstream to the server:

 1. A request line comprised of:
   1. An HTTP Verb. In our use case, we use `GET`
   2. The resource we're looking for. In this case, `/`
   3. The version of HTTP we're using.
 2. [HTTP headers](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers), which provide key/value pairs of information relevant to the current request/response cycle.
 3. A blank line to let the server know we're done talking.

# The HTTP Response

Now that all the request data was sent off, we grab the incoming text until there is none left and close the connection.

```ruby

while line = connection.gets
  puts line # Print the response data until we run out of text.
end

puts "Done downloading #{url.to_s}"
connection.close

```

This resulted in the following response:

```
HTTP/1.1 200 OK
Server: nginx/1.2.1
Date: Fri, 24 Apr 2015 16:49:01 GMT
Content-Type: text/html
Content-Length: 10261
Last-Modified: Sun, 12 Apr 2015 17:23:46 GMT
Connection: close
Accept-Ranges: bytes

<!DOCTYPE html>
<html>
```

The server sent us back a couple of things:

 1. The Response Line: Similar to the request line. Includes a version and [response code](http://www.w3.org/Protocols/rfc2616/rfc2616-sec6.html). Everything went well in our example so we received a `200 OK`.
 2. Response Headers: Similar to the request header
 3. An empty line to get us ready for ...
 4. The Response Body: The HTML you've come to know and love.

Since we sent `Connection: close` as a request header, the TCP Connection to the server closes at this point. In real world applications, the server will maintaing a [persistent connection](https://en.wikipedia.org/wiki/HTTP_persistent_connection) to optimize performance.

# Going Further

Knowing the ins and outs of the HTTP request / response cycle is essential for advancing in web development. Now that you have a basic understanding of HTTP 1.1, consider learning about the upcoming [HTTP 2.0 standard](https://en.wikipedia.org/wiki/HTTP/2), [WebSockets](https://en.wikipedia.org/wiki/WebSocket) and [HTTPS](https://en.wikipedia.org/wiki/HTTPS).
