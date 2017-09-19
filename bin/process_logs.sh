#!/bin/bash
p1=$(pwd)
BATS_TMPDIR=`mktemp --directory`
for i do
	name=$(echo "$i" | cut -d '/' -f 2 | cut -d '_' -f 1) 
	mkdir $BATS_TMPDIR/$name
	tar -zxf $i -C $BATS_TMPDIR/$name
	bin/process_client_logs.sh $BATS_TMPDIR/$name
done
bin/create_username_dist.sh $BATS_TMPDIR
bin/create_hours_dist.sh $BATS_TMPDIR
bin/create_country_dist.sh $BATS_TMPDIR
bin/assemble_report.sh $BATS_TMPDIR
mv $BATS_TMPDIR/failed_login_summary.html $p1
rm -rf $BATS_TMPDIR
