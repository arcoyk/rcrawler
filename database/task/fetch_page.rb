require "uri"
require "digest"
require "fileutils"
require "open-uri"
require "resque"
load "/users/kitayui/project/rcrawler/database/task/extract_page.rb"

class FetchPage
  @queue = :cnet_fetch
  def self.perform(url)
    url_hash = Digest::SHA256.hexdigest url.to_s

    path = "/users/kitayui/project/rcrawler/tmp/pages/#{url_hash}.html"
    puts "fetching : #{path}"

    data = open(url).read
    open(path, "w") do |f|
      f.write(data)
      Resque.enqueue ExtractPage, url
    end
  end
end