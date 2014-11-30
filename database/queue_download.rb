require "resque"
require "sqlite3"
load File.expand_path "../task/fetch_page.rb", __FILE__

db_path = File.expand_path "../../tmp/cnet.db", __FILE__
db = SQLite3::Database.new db_path

db.execute(
  "SELECT url FROM pages WHERE body IS NULL"
).each do |row|
  url = row[0]
  puts "fetching : #{url.to_s}"
  Resque.enqueue FetchPage, url
end