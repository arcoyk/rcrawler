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
			ing.downcase!
			puts ing
			ing.split(" ").each do |word|
				words.push word
			end
		end
	end
end

words.sort! do |w1, w2|
	# words.count(w1) <=> words.count(w2)
end

words.uniq!.reverse!

tgr = EngTagger.new

words.each do |word|
	if tgr.get_nouns(tgr.add_tags(word)).length > 0
		# puts word
	end
end
