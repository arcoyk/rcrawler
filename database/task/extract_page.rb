require "digest"
require "nokogiri"
require "sqlite3"

class ExtractPage
  @queue = :cnet_extract
  def self.perform(url)
    url_hash = Digest::SHA256.hexdigest url.to_s

    path = "/users/kitayui/project/rcrawler/tmp/pages/#{url_hash}.html"
    doc = Nokogiri::HTML open(path)

    body = doc.css("#postingbody").inner_text
    if (body == nil)
      puts "nil"
    end
    puts "extracting : #{body}"

    db_path = "/users/kitayui/project/rcrawler/tmp/cnet.db"
    db = SQLite3::Database.new db_path
    db.execute(
      "UPDATE pages SET body = ? WHERE url = ?",
      body, url
    )
  end
end