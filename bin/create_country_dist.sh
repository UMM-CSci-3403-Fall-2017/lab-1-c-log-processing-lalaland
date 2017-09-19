#!/bin/bash
p1=$(pwd)
cd $1
find . -name "failed_login_data.txt" -exec cat {} + > failed_login_data.txt
awk '{print $5}' failed_login_data.txt > IP_data.txt
rm failed_login_data.txt
while read; do     
	echo -n "$REPLY ";     
	fgrep -ow "$REPLY" IP_data.txt | wc -l; 
done < <(sort -u IP_data.txt) >> sorted_IP_data.txt
rm IP_data.txt
join -j 1 -o 1.1,1.2,2.2 $p1/etc/country_IP_map.txt sorted_IP_data.txt >> country_data.txt
rm sorted_IP_data.txt
awk -i inplace '{sub(/^\S+\s*/,"")}1' country_data.txt
awk '{arr[$1]+=$2;} END {for (i in arr) print i, arr[i]}' country_data.txt >> country_wo_data.txt
rm country_data.txt
sort country_wo_data.txt >> sorted_country_data.txt
rm country_wo_data.txt
sed -i 's/^/data.addRow([\x27/g' sorted_country_data.txt
sed -i 's/ /\x27, /g' sorted_country_data.txt
sed -i 's/$/]);/g' sorted_country_data.txt
cd $p1
bin/wrap_contents.sh $1/sorted_country_data.txt html_components/country_dist country_dist.html 
mv country_dist.html $1
rm $1/sorted_country_data.txt
