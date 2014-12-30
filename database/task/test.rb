require "open-uri"
require "nokogiri"

url = "http://allrecipes.com/Recipe/Braised-Balsamic-Chicken/"

doc = Nokogiri::HTML open(url)
# p doc
# p doc.title
charset = "utf-8"
doc = Nokogiri::HTML.parse(open(url), nil, charset)
p doc.title
p doc.body
