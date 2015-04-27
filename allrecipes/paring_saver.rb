f = File.new("tmp_parings/"+Time.now.to_s+".js", 'w')
f.puts(File.new("parings.js").read)
f.close