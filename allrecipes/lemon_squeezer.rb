require "sqlite3"
require "engtagger"
require "levenshtein"

db = SQLite3::Database.new "recipe.db"
ing_lists = db.execute("SELECT ingredients FROM recipes")
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

puts words