require './my_math.rb'

class Pair
	attr_accessor :ave, :dist, :ings, :num
	def initialize ave, dist, ings, num
		@ave = ave
		@dist = dist
		@ings = ings
		@num = num
	end
	def kind ave_ave, dist_ave
		if ave <= ave_ave && dist <= dist_ave
			return 0
		elsif ave <= ave_ave && dist >= dist_ave
			return 1
		elsif ave >= ave_ave && dist <= dist_ave
			return 2
		elsif ave >= ave_ave && dist >= dist_ave
			return 3
		end
	end
end

data = File.open("distance_map.txt").read.split("\n")
ings = data[0].split("&&&&")

def ings_preprosess ings
	new_ings = []
	ings.each do |ing|
		new_ings.push ing.gsub("'", "\\\\'")
	end
	return new_ings
end

mat = []
for i in 1..data.length-1
	tmp = data[i].split(" ")
	tmp_arr = []
	tmp.each do |digit|
		tmp_arr.push digit.to_i
	end
	mat.push tmp_arr
end

def ings_example ings
	puts
	puts "============ INGREDIENTS ============"
	puts ings.sample(10)
	puts "(Randomly sampled from " + ings.length.to_s + " ingredients.)"
	puts "====================================="
	puts
end

def pair_example ings, mat, n, extra
	samples = ings.sample n
	indexes = []
	data = []
	extra.each do |e|
		samples.push e
	end
	samples.each do |sample|
		indexes.push(ings.index(sample))
	end
	# extra.each do |e|
	# 	indexes.push(ings.index(e))
	# end
	for i in 0..indexes.length-1
		for j in i+1..indexes.length-1
			index1 = indexes[i]
			index2 = indexes[j]
			data.push mat[index1][index2]
		end
	end
	$aves.push data.avg
	$dists.push data.sd
	# return "['" + samples.join(", ") + "', " + data.avg.to_s + ", " + data.sd.to_s + ", " + n.to_s + ", 1]"
	return Pair.new data.avg, data.sd, samples, n
end

$aves = []
$dists = []
ings = ings_preprosess ings
parings = []

extra = ["bourbon whiskey", "chinese five-spice powder", "fresh red raspberries", "dried rosemary"]

while 1 do
	ex = pair_example ings, mat, 2, extra
	puts ex.ings.join(" + ")
end

# parings.each do |p|
# 	puts [p.ings.join(" + "), (p.ave * 100).round.to_s, (p.dist * 100).round.to_s, p.num, p.kind($aves.avg, $dists.avg)].reverse.join(", ")
# end



# parings_jsarr = <<EOS
# var parings = new Object();
# parings.arr = [
#           ['Pair', 'Dist SD', 'Dist Ave', 'Size', ''],
# EOS
# parings_jsarr += parings.join(",\n")
# parings_jsarr += "];"

# puts parings_jsarr