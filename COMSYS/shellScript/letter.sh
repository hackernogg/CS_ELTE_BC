#!/bin/sh

while read line
do
	set -- $line
	sed -e "s/name/$1/; s/adress/$2/; s/date/$3/" myletter >> $1.txt
done < people
