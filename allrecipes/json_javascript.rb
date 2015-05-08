require 'json'
str = File.open('json_stream.sock').read
str.gsub!(':', '=>')
str = eval(str)

str = Hash[str.sort]
str.each do |key, val|
	str[key] = Hash[val.sort]
end

puts ("function get_item_list() { return [")
tmp = []
str[str.first.first].each do |k, m|
	tmp.push "\"" + k + "\""
end
puts tmp.join(",")
puts ("];}")

puts

puts ("function get_matrix() { return [")
tmp = []
tmp_tmp = []
str.each do |e, k|
	k.each do |c, m|
		tmp.push m
	end
	tmp_tmp.push "[" + tmp.join(",") + "]"
end
puts tmp_tmp.join(",")
puts ("];}")