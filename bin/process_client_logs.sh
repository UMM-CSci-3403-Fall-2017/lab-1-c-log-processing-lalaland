#!/bin/bash
cd $1
p1=$(pwd)
find . -type f -exec cat {} + > ../login_data.txt
cd ..
mv login_data.txt $p1
cd $p1
awk '$6 == "Failed"' login_data.txt > login_data1.txt
awk '$7 == "password"' login_data1.txt > failed_login_data.txt
rm login_data.txt
rm login_data1.txt
sed -i 's/\(:\).*\(for \)/ /g' failed_login_data.txt
sed -i 's/invalid user //g' failed_login_data.txt
sed -i 's/from //g' failed_login_data.txt
sed -i 's/\( port\).*//g' failed_login_data.txt
