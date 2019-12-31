#!/bin/sh
characters_encoded=$(nkf -WwMQ gen-characters.rq | sed -e 's/=$//g' | tr = % | tr -d '\n')
characters_result=$(curl -s --fail "https://prismdb.takanakahiko.me/sparql?default-graph-uri=&query=$characters_encoded&format=text%2Fcsv" | tail +3 | sed '$d' | LC_ALL=C sort)
echo "$characters_result" | grep ';; okuri-nasi' > /dev/null && echo "$characters_result" > SKK-JISYO.prismdb.characters.utf8

songs_encoded=$(nkf -WwMQ gen-songs.rq | sed -e 's/=$//g' | tr = % | tr -d '\n')
songs_result=$(curl -s --fail "https://prismdb.takanakahiko.me/sparql?default-graph-uri=&query=$songs_encoded&format=text%2Fcsv" | tail +3 | sed '$d' | LC_ALL=C sort)
echo "$songs_result" | grep ';; okuri-nasi' > /dev/null && echo "$songs_result" > SKK-JISYO.prismdb.songs.utf8

# teams_encoded=$(nkf -WwMQ gen-teams.rq | sed -e 's/=$//g' | tr = % | tr -d '\n')
# teams_result=$(curl -s --fail "https://prismdb.takanakahiko.me/sparql?default-graph-uri=&query=$teams_encoded&format=text%2Fcsv" | tail +3 | sed '$d' | LC_ALL=C sort)
# echo "$teams_result" | grep ';; okuri-nasi' > /dev/null && echo "$teams_result" > SKK-JISYO.prismdb.teams.utf8

cat SKK-JISYO.prismdb.{characters,songs}.utf8 | LC_ALL=C sort | uniq > SKK-JISYO.prismdb.all.utf8
