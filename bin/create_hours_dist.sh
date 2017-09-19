#!/bin/bash
p1=$(pwd)
cd $1
find . -name "failed_login_data.txt" -exec cat {} + > failed_login_data.txt
awk '{print $3}' failed_login_data.txt > hours_data.txt
rm failed_login_data.txt
while read; do     
	echo -n "$REPLY ";     
	fgrep -ow "$REPLY" hours_data.txt | wc -l; 
done < <(sort -u hours_data.txt) >> sorted_hours_data.txt
rm hours_data.txt
sed -i 's/^/data.addRow([\x27/g' sorted_hours_data.txt
sed -i 's/ /\x27, /g' sorted_hours_data.txt
sed -i 's/$/]);/g' sorted_hours_data.txt
cd $p1
bin/wrap_contents.sh $1/sorted_hours_data.txt html_components/hours_dist hours_dist.html 
mv hours_dist.html $1
rm $1/sorted_hours_data.txt
