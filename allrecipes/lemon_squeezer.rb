require "sqlite3"
require "dijkstra"

def show_map map
	puts
	map.each do |col|
		puts col.join(" ")
	end
end

def linkval ing1, ing2
	return $link_map[$list_hash[ing1]][$list_hash[ing2]]
end

db = SQLite3::Database.new "recipe.db"
ing_lists = db.execute("SELECT ingredients FROM recipes LIMIT 3")
# ing_lists = [["butter &&&& bean"],
#  			["butter &&&& orange"],
#  			["butter &&&& orange &&&& cream"]]
recipes = []
ing_lists.each do |ing_list|
	ings = []
	ing_list.last.split("&&&&").each do |ing|
		ing.delete!(',')
		ing.delete!(';')
		ing.delete!(':')
		ing.delete!('*')
		ing.strip!
		ing.downcase!
		if ing.length > 3
			ings.push ing
		end
	end
	recipes.push ings
end


$list = recipes.flatten
$list.sort! do |ing1, ing2|
	$list.count(ing1) <=> $list.count(ing2)
end
$list.uniq!.reverse!

recipes.each do |recipe|
	recipe.uniq!
end

length = $list.length

# init which ing with which ing map
$link_map = []
length.times do
	column = Array.new(length, 0)
	$link_map.push column
end
$list_hash = {}
list_index = []
length.times do |index|
	list_index.push index
end
alist = $list.zip(list_index)
$list_hash = Hash[alist]

# create which ing with which ing map
$list.each do |item|
	recipes.each do |ings|
		if ings.include? item
			ings.each do |ing|
				item_id = $list_hash[item]
				ing_id = $list_hash[ing]
				$link_map[item_id][ing_id] += 1
			end
		end
	end
end

# diagonal zero
length.times do |row|
	length.times do |col|
		if col == row
			$link_map[row][col] = 0
		end
	end
end

# error check
length.times do |row|
	length.times do |col|
		if $link_map[col][row] != $link_map[row][col]
			$link_map[col][row] = 'x'
			$link_map[row][col] = 'x'
		end
	end
end

python_code = " # -*- coding: utf-8 -*- \n"

python_code += <<EOS
import networkx as nx
G = nx.Graph()
EOS

for row in 0..length-1
	row_ing = $list[row]
	for col in 0..length-1
		col_ing = $list[col]
		weight = $link_map[row][col]
		if weight == 0
			next
		end
		str = 'G.add_edge("' + row_ing + '","' + col_ing + '",' + "weight=" + weight.to_s + ")"
		python_code += str + "\n"
	end
end
python_code += <<EOS
sp_mat = nx.all_pairs_dijkstra_path_length(G, cutoff=None, weight='weight')
print sp_mat
EOS

puts python_code


# # find shortest path
# link_summary = []
# max_val = $link_map.flatten.max
# length.times do |row|
# 	length.times do |col|
# 		val = $link_map[row][col]
# 		if val != 0
# 			link_summary.push [row, col, max_val - val + 1]
# 		end
# 	end
# end

# link_summary.unshift [$list.length]

# puts link_summary.inspect

# $distance_map = []
# length.times do
# 	column = Array.new(length, 0)
# 	$distance_map.push column
# end

# length.times do |row|
# 	length.times do |col|
# 		result = Dijkstra.new(row, col, link_summary)
# 		$distance_map[row][col] = result.getCost()
# 	end
# 	print "."
# end

# show_map $distance_map

# puts "........."

# puts $list_hash