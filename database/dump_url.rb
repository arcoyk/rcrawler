#cf http://yamitzky.hatenablog.com/entry/2013/12/31/034821 (japanese)

require "open-uri"
require "nokogiri"
require "uri"
require "sqlite3"

def parse_time(str)
  year = str.slice(0..3).to_i
  month = str.slice(4..5).to_i
  day = str.slice(6..7).to_i
  DateTime.new year, month, day
end

db_path = File.expand_path "../../tmp/cnet.db", __FILE__
db = SQLite3::Database.new db_path

url = "http://sfbay.craigslist.org/"
top_page_html = Nokogiri::HTML(open(url))

top_page_html.css("a").each do |top_el|
  begin
    url = URI.join("http://sfbay.craigslist.org/", top_el.attr("href"))
  rescue URI::InvalidURIError => e
    next
  rescue  URI::HTTPRedirect => e
    next
  end
  sub_page_html = Nokogiri::HTML(open(url))
  puts "subpage -> #{url.to_s}"  

  sub_page_html.css("a").each do |sub_el|
    next if sub_el.attr("class") != "hdrlnk"
    begin
      url = URI.join("http://sfbay.craigslist.org/", sub_el.attr("href"))
    rescue URI::InvalidURIError => e
      next
    rescue  URI::HTTPRedirect => e
      next
    end
    puts "contents -> #{url.to_s}"
    db.execute("INSERT OR IGNORE INTO pages VALUES(?, ?, ?)",
                url.to_s, nil, nil)
    p url
  end
end

