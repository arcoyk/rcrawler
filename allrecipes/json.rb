require 'json'
str = "{'A': {'A': 0, 'C': 8, 'B': 5, 'D': 1}, 'C': {'A': 8, 'C': 0, 'B': 3, 'D': 9}, 'B': {'A': 5, 'C': 3, 'B': 0, 'D': 6}, 'D': {'A': 1, 'C': 9, 'B': 6, 'D': 0}}"
str.gsub!(':', '=>')
str = eval(str)

str[str.first.first].each do |k, m|
	puts k
end

puts 444

str.each do |e, k|
	puts k
	k.each do |c, m|
		print m
		print " "
	end
	puts
end