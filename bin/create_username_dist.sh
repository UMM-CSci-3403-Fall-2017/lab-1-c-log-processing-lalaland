#!/bin/bash
p1=$(pwd)
cd $1
find . -name "failed_login_data.txt" -exec cat {} + > failed_login_data.txt
awk '{print $4}' failed_login_data.txt > username_data.txt
rm failed_login_data.txt
sort username_data.txt | uniq -c | awk '{print $2" "$1}'> sorted_username_data.txt
rm username_data.txt
sed -i 's/^/data.addRow([\x27/g' sorted_username_data.txt
sed -i 's/ /\x27, /g' sorted_username_data.txt
sed -i 's/$/]);/g' sorted_username_data.txt
cd $p1
bin/wrap_contents.sh $1/sorted_username_data.txt html_components/username_dist username_dist.html 
mv username_dist.html $1
rm $1/sorted_username_data.txt
