#!/bin/sh
for NM in `cat $1`
do
 exec < $2
       while read X Y
          do
		if [ "$NM" -eq "$X" ]; then
		echo "$Y"
                fi 
          done  	
done
