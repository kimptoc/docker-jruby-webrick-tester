# JRuby webrick/REXML 1.7.23/24 tester

If you run 'as-is'
```
docker-compose build
docker-compose up
```

Runs ok - 2 clients connect to the webservice, no issues

If you amend the docker-compose.yml - change 1.7.23 to 1.7.24 and run again.

It will fail with an error like this:

```
server_1       | 2016-03-03 08:41:35 +0000:<?xml version="1.0" encoding="utf-8" ?>
server_1       |     <pulse>
server_1       |           <dateTime>2016-03-03 08:41:34 +0000</dateTime>
server_1       |     </pulse>
server_1       |
server_1       | 172.17.0.3 - - [03/Mar/2016:08:41:34 UTC] "GET /heartbeat HTTP/1.1" 200 775
server_1       | - -> /heartbeat
server_1       | 172.17.0.4 - - [03/Mar/2016:08:41:34 UTC] "GET /heartbeat HTTP/1.1" 200 775
server_1       | - -> /heartbeat
client2_1      | REXML::ParseException: #<REXML::ParseException: malformed XML: missing tag start
client2_1      | Line: 18
client2_1      | Position: 775
client2_1      | Last 80 unconsumed characters:
client2_1      | <ArgumentError: Bad encoding name utf-8> /opt/jruby/lib/ruby/1.9/rexml/encoding.r>
client2_1      | /opt/jruby/lib/ruby/1.9/rexml/parsers/baseparser.rb:367:in `pull_event'
client2_1      | /opt/jruby/lib/ruby/1.9/rexml/parsers/baseparser.rb:183:in `pull'
client2_1      | /opt/jruby/lib/ruby/1.9/rexml/parsers/treeparser.rb:22:in `parse'
client2_1      | /opt/jruby/lib/ruby/1.9/rexml/document.rb:249:in `build'
client2_1      | /opt/jruby/lib/ruby/1.9/rexml/document.rb:43:in `initialize'
client2_1      | scripts/client.rb:26:in `(root)'
client2_1      | org/jruby/RubyRange.java:479:in `each'
client2_1      | scripts/client.rb:19:in `(root)'
client2_1      | /opt/jruby/lib/ruby/1.9/net/http.rb:746:in `start'
client2_1      | scripts/client.rb:16:in `(root)'
client2_1      | ...
client2_1      | malformed XML: missing tag start
client2_1      | Line: 18
client2_1      | Position: 775
client2_1      | Last 80 unconsumed characters:
client2_1      | <ArgumentError: Bad encoding name utf-8> /opt/jruby/lib/ruby/1.9/rexml/encoding.r
client2_1      | Line: 18
client2_1      | Position: 775
client2_1      | Last 80 unconsumed characters:
client2_1      | <ArgumentError: Bad encoding name utf-8> /opt/jruby/lib/ruby/1.9/rexml/encoding.r
client2_1      |        parse at /opt/jruby/lib/ruby/1.9/rexml/parsers/treeparser.rb:95
client2_1      |        build at /opt/jruby/lib/ruby/1.9/rexml/document.rb:249
client2_1      |   initialize at /opt/jruby/lib/ruby/1.9/rexml/document.rb:43
client2_1      |       (root) at scripts/client.rb:26
client2_1      |         each at org/jruby/RubyRange.java:479
client2_1      |       (root) at scripts/client.rb:19
client2_1      |        start at /opt/jruby/lib/ruby/1.9/net/http.rb:746
client2_1      |       (root) at scripts/client.rb:16
client1_1      | REXML::ParseException: #<REXML::ParseException: malformed XML: missing tag start
```