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