require "resque"
require "sqlite3"
load "./fetch_page.rb"

db = SQLite3::Database.new "../recipe.db"

db.execute(
  "select url from visited where url like 'http://allrecipes.com/recipe/%' "
).each do |row|
  url = row[0].split('/').slice(0...5).join('/')
  puts "queing : #{url.to_s}"
  Resque.enqueue FetchPage, url
end