#!/bin/sh



# number of windows
K=69
win_0=14.0 # A
win_inc=0.25 # A
spring=209.2 # kcal/mol/A2 --> kJ/mol/A2

# Generate the index file
seq $K | awk '{printf("%.2f %d\n", '$win_0'+'$win_inc'*($1-1), '$spring')}'  > data/centers.dat

# concatenate the data file
# skip the first 5 entries for each trajectory
skip=5
#skip=15

num_cp=5
for i in `seq $K`; do
    win=`echo $i | awk '{printf("%.2f",'$win_0'+'$win_inc'*($1-1))}'`
    rm -f data/CaM_CaMKIIp_Stab_${i}.txt
    for j in `seq $num_cp`; do
        awk ' NR > '$skip' {print $1}'  CaM_CaMKIIp_Stab_${win}_${j}.txt >> data/CaM_CaMKIIp_Stab_${i}.txt
    done
done

