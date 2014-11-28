#!/usr/bin/env ruby

require "open-uri"
require "nokogiri"
require "uri"
require "sqlite3"

db_path = File.expand_path "../tmp/cnet.db", __FILE__
db = SQLite3::Database.new db_path

url = "http://news.cnet.com"
months_html = Nokogiri::HTML(open(url))
months_html.css("a").each do |month_el|
	if month_el.text == "Site Inbox"
		next
	end
	if month_el.text.slice(-4, 4).to_i > 2008
		next
	end

	url = URI.join("http://news.cnet.com/", month_el.attr("href"))
    parts_html = Nokogiri::HTML(open(url))

    parts_html.css("a").each do |part_el|
    	url = URI.join("http://news.cnet.com/", part_el.attr("href"))
    	html = Nokogiri::HTML(open(url))

    	queries = url.query.split("&").map{|pair| pair.split("=")}
    	queries = Hash[*queries.flatten]
    	time = parse_time(queries["begin"])

	    html.css("a").each do |news_el|
    		begin
        		url = URI.join("http://news.cnet.com/", news_el.attr("href"))
      		rescue URI::InvalidURIError => e
        		next
      		end
      	db.execute("INSERT OR IGNORE INTO pages VALUES(?, ?, ?)", url.to_s, nil, time.strftime("%Y-%m-%d %T"))
        puts url
    end
    sleep 3
  end
end