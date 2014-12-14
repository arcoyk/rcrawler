require "open-uri"
require "nokogiri"
require "uri"
require "sqlite3"

def recursive_crawler(url)
  puts "START : " + url
  begin
    html = Nokogiri::HTML(open(url, :redirect => false))
  rescue OpenURI::HTTPRedirect => redirect
    return
  end
  $db.execute("INSERT OR IGNORE INTO visited values(?, ?)", url.to_s, Time.now.to_s);
  html.css("a").each do |a_el|
    new_url = a_el.attr("href").to_s
    if new_url.index($site_root) != 0
      next
    end
    if $db.execute("SELECT * FROM visited WHERE url=?", new_url.to_s).length == 0
      puts "FIND : " + new_url
      recursive_crawler(new_url);
    end
  end
  return
end

$db = SQLite3::Database.new "recipe.db"
$site_root = "http://allrecipes.com/"
recursive_crawler($site_root)



#  if (html.css("#zoneRecipe").length != 0)
#    $db.execute("INSERT OR IGNORE INTO recipes VALUES(?, ?, ?)",
#                url.to_s, nil, nil);
#    puts "dumped"
#  end