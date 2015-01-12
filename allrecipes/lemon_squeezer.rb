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
ing_lists = db.execute("SELECT ingredients FROM recipes")
recipes = []
ing_lists.each do |ing_list|
	ings = []
	ing_list.last.split("&&&&").each do |ing|
		ing.delete!(',')
		ing.delete!(';')
		ing.delete!('*')
		ing.strip!
		ing.downcase!
		if ing.length > 3
			ings.push ing
		end
	end
	recipes.push ings
end

ing_list = recipes.flatten

p ing_list

=begin
words = []
ing_lists.each do |ing_list|
	ing_list.each do |ings|
		ings.split("&&&&").each do |ing|
			ing.delete!(',')
			ing.delete!(';')
			ing.delete!('*')
			ing.strip!
			ing.downcase!
			if ing.length > 3
				words.push ing
			end
		end
	end
end

words.sort! do |w1, w2|
	words.count(w1) <=> words.count(w2)
end
words.uniq!
=end

# init example
=begin
s = "some"
c = "cone"
t = "tall"
h = "shade"
recipes = [[s, c],
		   [c, t],
		   [t, h],
		   [h]]
$list = [s, c, t, h]
length = $list.length
list_index = []
length.times do |index|
	list_index.push(index)
end
alist = $list.zip(list_index)
$list_hash = Hash[alist]

# init map
$link_map = []
length.times do
	column = Array.new(length, 0)
	$link_map.push(column)
end
=end



=begin
# create map
$list.each do |item|
	recipes.each do |ings|
		if ings.include? item
			ings.each do |ing|
				item_id = $list_hash[item]
				ing_id = $list_hash[ing]
				$link_map[item_id][ing_id] += 2
			end
		end
	end
end

# fold map
length.times do |row|
	length.times do |col|
		$link_map[col][row] *= 2
		if col == row
			$link_map[col][row] = 0
		end
	end
end

show_map $link_map

# dijkstra test
link_summary = []
length.times do |row|
	length.times do |col|
		val = $link_map[col][row]
		if val != 0
			link_summary.push [col, row, val]
		end
	end
end

link_summary.unshift [link_summary.length]

show_map link_summary

result = Dijkstra.new(1, 3, link_summary)
p result.getShortestPath()
p result.getCost()
=end
