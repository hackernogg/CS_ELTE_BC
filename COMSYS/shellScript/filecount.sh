#!/bin/sh
#the first way
noext="/"
noextcheck=0
find -type f | sed -e 's/.*\.//' | sort | uniq -c >> filecount.txt
sed -i '\#'"$noext"'#d' filecount.txt
for i in *. ;do
	noextcheck=$(find . ! -name "*.*" | wc -l)
done
echo "      $noextcheck No extension" >> filecount.txt
#the second way
: '
#!/bin/sh
jpg=0
gif=0
txt=0
noext=0
for i in *.txt; do
	txt=$((txt + 1))
done
for i in *.gif; do
	gif=$((gif + 1))
done
for i in *.jpg; do
        jpg=$((jpg + 1))
done
for i in *. ;do
	noext=$(find . ! -name "*.*" | wc -l)
done
echo "noext=$noext
txt=$txt
jpg=$jpg
gif=$gif" >> filecount1.txt
'
