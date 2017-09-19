#!/bin/bash
p1=$(pwd)
cd $1
cat country_dist.html hours_dist.html username_dist.html >> failed_login_summary.txt
cd $p1
bin/wrap_contents.sh $1/failed_login_summary.txt html_components/summary_plots failed_login_summary.html
mv failed_login_summary.html $1
rm $1/failed_login_summary.txt
