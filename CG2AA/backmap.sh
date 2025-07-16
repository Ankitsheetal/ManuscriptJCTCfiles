#!/bin/bash
## Usage: sh CHECK.sh LIST 1_cg.pdb 1_aa.pdb
## Caution: 1_aa.pdb will update in every loop, so keep a copy of 1_aa.pdb for backup in case of misexecution.

#scp -r complete.pdb backmap/
#scp -r aa.pdb backmap/
#scp -r cg.pdb backmap/
#cd backmap
rm converted.pdb
for (( q=1; q<81; q++ ))

do

awk '{ if ($5=='$q') {printf "%4s  %5s %4s%4s %5s %11s%8s%8s %5s %5s %13s\n", "ATOM",$2,$3,$4,$5,$6,$7,$8,$9,$10,$11}}' mmt_cg.pdb > cg`expr $q`.pdb

awk '{ if ($5=='$q') {printf "%4s  %5s %4s%4s %5s %11s%8s%8s %5s %5s %13s\n", "ATOM",$2,$3,$4,$5,$6,$7,$8,$9,$10,$11}}' mmt_aa.pdb > aa`expr $q`.pdb

awk '{ if ($5=='$q') {printf "%4s  %5s %4s%4s %5s %11s%8s%8s %5s %5s %13s\n", "ATOM",$2,$3,$4,$5,$6,$7,$8,$9,$10,$11}}' partial1.pdb > part`expr $q`.pdb

#sh diff.sh LIST1 aa`expr $q`.pdb cg`expr $q`.pdb output1.dat
#sh diff2.sh LIST2 aa`expr $q`.pdb cg`expr $q`.pdb output2.dat

sh shift.sh LIST`expr $q` cg`expr $q`.pdb aa`expr $q`.pdb part`expr $q`.pdb

cat part`expr $q`.pdb >> converted1.pdb
rm cg`expr $q`.pdb
rm aa`expr $q`.pdb
rm part`expr $q`.pdb
#awk '{printf "%4s  %5s %4s%4s %5s %11s%8s%8s %5s %5s %13s\n", "ATOM",$2,$3,$4,$5,$6,$7,$8,$9,$10,$11}' comp`expr $q`.pdb >> final.pdb
done


