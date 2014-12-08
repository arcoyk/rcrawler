rcrawler
========

A crawler using Ruby &amp; SQLite

Initial Setup
MacOS X
Ruby 2.0

Problem and Solution

cf: http://yamitzky.hatenablog.com/entry/2013/12/31/034821 (japanese)

1. Cannot fetch pages from CNET.com
There was an error on fetching URL of cnet.com, simply because the website has been updated. So, changed targed to http://sfbay.craigslist.org/sfc/ craigslist.

2. "require "resque"" -> "resque" not found

gem install resque

3. radis connection error

brew update
brew install redis
(not gem)

redis-server

4. no Rakefile
make it own:
load -
load -
require -

then

5. How to start crawling

radis-server (start server)
$ PIDFILE=./resque-extract.pid BACKGROUND=yes QUEUE=cnet_extract rake resque:work
$ PIDFILE=./resque-fetch.pid INTERVAL=5 BACKGROUND=yes QUEUE=cnet_fetch rake resque:work
