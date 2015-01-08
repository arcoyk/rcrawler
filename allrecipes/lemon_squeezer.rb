require "sqlite3"



db = SQLite3::Database.new "recipe.db"
ing_lists = db.execute("SELECT ingredients FROM recipes")
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

=begin
db.execute("DROP TABLE link_map")

s = "some"
c = "cone"
t = "tall"
h = "shade"

recipes = [[s, c, t, h],
		   [s, c],
		   [t, h],
		   [t, c]]

list = ["some", "cone","tall", "shade"]

query = "CREATE TABLE link_map ("
list.each do |item|
	query += item + " int"
	if item != list.last
		query += ", "
	end
end
query += ")"
db.execute(query)
=end


