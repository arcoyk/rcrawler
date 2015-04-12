require 'json'
str = File.open('json_stream.sock').read
str.gsub!(':', '=>')
str = eval(str)

str[str.first.first].each do |k, m|
	print k
	print " "
end
puts
str.each do |e, k|
	k.each do |c, m|
		print m
		print " "
	end
	puts
end