require "digest"
require "nokogiri"
require "sqlite3"

class ExtractPage
  @queue = :cnet_extract
  def self.perform(url)
    url_hash = Digest::SHA256.hexdigest url.to_s

    path = File.expand_path "../tmp/pages/#{url_hash}.html", __FILE__
    doc = Nokogiri::HTML open(path)

    body = doc.css("#postingbody")
    put "extracted : #{body}"

    db_path = File.expand_path "../tmp/cnet.db", __FILE__
    db = SQLite3::Database.new db_path
    db.execute(
      "UPDATE pages SET published_at = ?, body = ? WHERE url = ?",
      uil, body, url
    )
  end
end