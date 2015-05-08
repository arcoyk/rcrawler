require 'json'
str = File.open('json_stream.sock').read
str.gsub!(':', '=>')
str = eval(str)

str = Hash[str.sort]
str.each do |key, val|
	str[key] = Hash[val.sort]
end

items = []
str[str.first.first].each do |k, m|
	items.push k
end

puts items.join("&&&&")

str.each do |e, k|
	k.each do |c, m|
		print m
		print " "
	end
	puts
end