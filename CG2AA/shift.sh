#!/bin/bash
## Usage: sh CHECK_n.sh LIST_al cg1.pdb aa1.pdb comp1.pdb
## Caution: 1_aa.pdb will update in every loop, so keep a copy of 1_aa.pdb for backup in case of misexecution.

while read AL OX   
do 
    FL1=$(grep -w $AL $2 | awk '{print $6"\t"$7"\t"$8}'); 
    FL2=$(grep -w $AL $3 | awk '{print $6"\t"$7"\t"$8}'); 
    CRD=$(echo "$AL\t$FL1\t$FL2" | awk '{print $2-$5"\t"$3-$6"\t"$4-$7}')
    AX=$(echo $CRD | awk '{print $1}')
    AY=$(echo $CRD | awk '{print $2}')
    AZ=$(echo $CRD | awk '{print $3}')
    awk -v OX=$OX -v AX=$AX -v AY=$AY -v AZ=$AZ '{if ($3 == OX) printf "%4s  %5s %4s%4s %5s %11s%8s%8s %5s %5s %13s\n", "ATOM",$2,$3,$4,$5,($6+AX),($7+AY),($8+AZ),$9,$10,$11; else print $0}' $4 > TEMP.pdb
   mv TEMP.pdb $4
done < $1

