#!/bin/sh 

a=0
#the show time
FRE=0
#the word

if test $# -eq 1
#check if there is only one file
then
  if test -f $1
  #Check if the file exist
  then 
    while read row
    do
	#while loop to do ST. in every row.
      for word in $row
      do 
	  #for loop to do with the word
        count=`grep -o -a $word $1 | wc -l`
		#count the amount of show time
        if test $count -gt $a
		#Compare the most frequent one
        then
          a=$count
          FRE=$word
		  #give the variable to the show time and the word
        fi  
      done
    done < $1
    echo $a
    echo $FRE
	# out put the show time and the word
  else 
    echo PLZ enter a real file bruh.
	# warn user to check the enter file exist
  fi  
else
  echo PLZ enter the amount of the file bro !!!\(1\)
  # warn user to check the amount of enter file.
fi
