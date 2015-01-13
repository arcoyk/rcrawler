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
ing_lists = db.execute("SELECT ingredients FROM recipes LIMIT 10")
=begin
ing_lists = [["butter &&&& bean &&&& tomato"],
			["butter &&&& orange &&&& chocolate &&&& sugar"],
			["sugar &&&& bean"]]
			["sugar &&&& orange &&&& butter"],
			["olive oil &&&& tomato &&&& pasta &&&& butter &&&& sugar &&&& sugar"]]
=end
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
p length

# init map
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

# create map
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

# fix link map
length.times do |row|
	length.times do |col|
		if col == row
			$link_map[col][row] = 0
		end
	end
end
max_val = $link_map.flatten.max

length.times do |row|
	length.times do |col|
		if $link_map[col][row] != 0
			$link_map[col][row] = (max_val + 1) - $link_map[col][row]
		end
	end
end

length.times do |row|
	length.times do |col|
		if $link_map[col][row] != $link_map[row][col]
			$link_map[col][row] = 'x'
			$link_map[row][col] = 'x'
		end
	end
end

$list.each_with_index do |item, id|
	p "#{id} #{item}"
end
show_map $link_map


# find shortest path
# gem dijkstra requires node.id != 0, so shift index
link_summary = []
length.times do |row|
	shift_row = row + 1
	length.times do |col|
		shift_col = col + 1
		val = $link_map[col][row]
		if val != 0
			link_summary.push [shift_col, shift_row, val]
		end
	end
end

link_summary.unshift [link_summary.length]

# path cost cash
$distance_map = []
length.times do
	column = Array.new(length, 0)
	$distance_map.push column
end

r = Random.new
length.times do |row|
	length.times do |col|
		row = r.rand(length)
		col = r.rand(length)
		shift_row = row + 1
		shift_col = col + 1
		result = Dijkstra.new(shift_row, shift_col, link_summary)
		$distance_map[col][row] = result.getCost()
		p "#{$list[row]} -> #{$list[col]} : #{result.getCost()}"
		result.getShortestPath().each do |index|
			shift_index = index - 1
			print "#{$list[shift_index]} - "
		end
		puts ""
	end
end
