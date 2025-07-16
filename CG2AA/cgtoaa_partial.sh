#!/bin/bash
rm residue1.pdb
awk '{ if ($3!~/^AL/) {printf "%7s %5s %-4s %3s %5s %.3f %.3f %.3f  %5s %5s %13s\n", $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11}}' mmt_aa.pdb > modified.pdb

awk '{ if ($3!~/^MG/) {printf "%7s %5s %-4s %3s %5s %.3f %.3f %.3f  %5s %5s %13s\n", $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11}}' modified.pdb > newmodified.pdb

awk '{ if ($3!~/^SI/) {printf "%7s %5s %-4s %3s %5s %.3f %.3f %.3f  %5s %5s %13s\n", $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11}}' newmodified.pdb > ohmodified.pdb

for(( q=1; q<81; q++ ))
do
s=0
j=1
a=4
b=12
c=20
d=28
f=0

awk '{ if ($5=='$q') {printf "%4s  %5s %4s%4s %5s %11s%8s%8s %5s %5s %13s\n", "ATOM",$2,$3,$4,$5,$6,$7,$8,$9,$10,$11}}' mmt_cg.pdb > duummy.pdb
awk '{printf "%4s  %5s %4s%4s %5s %11s%8s%8s %5s %5s %13s\n", "ATOM",NR,$3,$4,$5,$6,$7,$8,$9,$10,$11}' duummy.pdb > cg1.pdb

awk '{ if ($5=='$q') {printf "%4s  %5s %4s%4s %5s %11s%8s%8s %5s %5s %13s\n", "ATOM",$2,$3,$4,$5,$6,$7,$8,$9,$10,$11}}' ohmodified.pdb > dummy.pdb
awk '{printf "%4s  %5s %4s%4s %5s %11s%8s%8s %5s %5s %13s\n", "ATOM",NR,$3,$4,$5,$6,$7,$8,$9,$10,$11}' dummy.pdb > res.pdb

for (( i=1; i<3; i++ ))
do
awk '{ if ($2>'$s' && $2 <= '$a') {printf "%4s  %5s %4s%4s %5s %11s%8s%8s %5s %5s %13s\n", "ATOM",$2,$3,$4,$5,$6,$7,$8,$9,$10,$11}}' cg1.pdb > end1.pdb

awk '{ if ($2>'$b' && $2 <= '$c') {printf "%4s  %5s %4s%4s %5s %11s%8s%8s %5s %5s %13s\n", "ATOM",$2,$3,$4,$5,$6,$7,$8,$9,$10,$11}}' cg1.pdb >> end1.pdb

awk '{ if ($2>'$f' && $2 <= '$d') {printf "%4s  %5s %4s%4s %5s %11s%8s%8s %5s %5s %13s\n", "ATOM",$2,$3,$4,$5,$6,$7,$8,$9,$10,$11}}' res.pdb >> end1.pdb
awk '{printf "%4s  %5s %4s%4s %5s %11s%8s%8s %5s %5s %13s\n", "ATOM",$2,$3,$4,$5,$6,$7,$8,$9,$10,$11}' end1.pdb >> residue1.pdb
s=$((s+4))
a=$((a+4))
b=$((b+8))
c=$((c+8))
d=$((d+28))
f=$((f+28))
done
d=$((d-28))
awk '{ if ($2>'$s' && $2 <= '$a') {printf "%4s  %5s %4s%4s %5s %11s%8s%8s %5s %5s %13s\n", "ATOM",$2,$3,$4,$5,$6,$7,$8,$9,$10,$11}}' cg1.pdb >> residue1.pdb
awk '{ if ($2>'$b' && $2 <= '$c') {printf "%4s  %5s %4s%4s %5s %11s%8s%8s %5s %5s %13s\n", "ATOM",$2,$3,$4,$5,$6,$7,$8,$9,$10,$11}}' cg1.pdb >> residue1.pdb

awk '{ if ($2 > '$d') {printf "%4s  %5s %4s%4s %5s %11s%8s%8s %5s %5s %13s\n", "ATOM",$2,$3,$4,$5,$6,$7,$8,$9,$10,$11}}' res.pdb >> residue1.pdb


done

awk '{printf "%4s  %5s %4s%4s %5s %11s%8s%8s %5s %5s %13s\n", "ATOM",NR,$3,$4,$5,$6,$7,$8,$9,$10,$11}' residue1.pdb > partial1.pdb

