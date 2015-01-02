require "digest"
require "nokogiri"
require "sqlite3"

db = SQLite3::Database.new "../recipe.db"
pages = Dir.glob("../pages/*")
pages.each do |path|
    doc = Nokogiri::HTML open(path)
    title = doc.css("#itemTitle").inner_text
    span_array = doc.css('span')
    ingredients = "";
    span_array.each do |span|
      if span.attr("id") == 'lblIngName'
        ingredients += " &&&& " + span.inner_text
      end
    end
    puts title
    puts ingredients
    db.execute(
      "INSERT OR IGNORE INTO recipes VALUES(?, ?, ?)",
      path, title, ingredients
    )
end
