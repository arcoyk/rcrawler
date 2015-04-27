if [ $1 = "build" ]; then
	ruby lemon_squeezer.rb > shortest_path.py
	python shortest_path.py > json_stream.sock
	ruby json.rb > distance_map.txt
fi
ruby random_create.rb > parings.js
ruby paring_saver.rb
open index.html