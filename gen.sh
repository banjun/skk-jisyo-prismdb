#!/bin/sh
encoded=$(nkf -WwMQ gen.rq | sed -e 's/=$//g' | tr = % | tr -d '\n')
result=$(curl -s --fail "https://prismdb.takanakahiko.me/sparql?default-graph-uri=&query=$encoded&format=text%2Fcsv" | tail +3 | sed '$d' | LC_ALL=C sort)
echo "$result" > SKK-JISYO.prismdb.all.utf8
