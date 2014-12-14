require "sqlite3"
require "fileutils"

path = "/users/kitayui/project/rcrawler/recipe.db"
puts path 
db = SQLite3::Database.new path
sql = <<-SQL
  CREATE TABLE recipes(
    url text,
    title text,
    ingredients text
  );
SQL

db.execute_batch sql
db.close