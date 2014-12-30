require "uri"
require "digest"
require "fileutils"
require "open-uri"
require "resque"
load "./extract_page.rb"

class FetchPage
  @queue = :recipe_fetch
  def self.perform(url)
    url_hash = Digest::SHA256.hexdigest url.to_s

    local_path = "./pages/#{url_hash}.html"
    puts "fetching : #{url.to_s}"

    html = open(url).read
    open(local_path, "w") do |file|
      file.write(html)
      Resque.enqueue ExtractPage, url
    end
  end
end