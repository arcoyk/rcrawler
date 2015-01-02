require "digest"
require "nokogiri"
require "sqlite3"

pages = Dir.glob("../pages/*")
pages.each do |path|
    doc = Nokogiri::HTML open(path)
    title = doc.css('#itemTitle')
    span_array = doc.css('span')
    ingredients = "";
    span_array.each do |span|
      if span.id == "lblIngName"
        ingredients += " &&&& " + span.innerText
      end
    end
    puts title
    puts ingredients

    db = SQLite3::Database.new "../recipe.db"
    db.execute(
      "UPDATE recipes SET title = ?, ingredients = ?, url = ? WHERE url = ?",
      title, ingredients, url, url
    )
end
