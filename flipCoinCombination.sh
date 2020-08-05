#!/bin/bash -x
H=1
T=2
H_H=3
H_T=4
T_H=5
T_T=6
H_H_H=7
H_H_T=8
H_T_H=9
T_H_H=10
H_T_T=11
T_T_H=12
T_H_T=13
T_T_T=14

NUM_OF_FLIPS=30

h_win=0
t_win=0
h_h_win=0
h_t_win=0
t_h_win=0
t_t_win=0
h_h_h_win=0
h_h_t_win=0
h_t_h_win=0
t_h_h_win=0
h_t_t_win=0
t_t_h_win=0
t_h_t_win=0
t_t_t_win=0

declare -A comboDict
declare -A percentDict

for (( i=1; i<=$NUM_OF_FLIPS; i++ ))
do
	flip_coin=$((RANDOM%14+1))
	case $flip_coin in
		$H)	h_win=$(($h_win+1))
			comboDict[$flip_coin]="H"
			;;
		$T)	t_win=$(($t_win+1))
			comboDict[$flip_coin]="T"
			;;
		$H_H)	comboDict[$flip_coin]="HH"
			h_h_win=$(($h_h_win+1))
			;;
		$H_T)	comboDict[$flip_coin]="HT"
			h_t_win=$(($h_t_win+1))
			;;
		$T_H)	comboDict[$flip_coin]="TH"
			t_h_win=$(($t_h_win+1))
			;;
		$T_T)	comboDict[$flip_coin]="TT"
			t_t_win=$(($t_t_win+1))
			;;
		$H_H_H)	comboDict[$flip_coin]="HHH"
			h_h_h_win=$(($h_h_h_win+1))
			;;
		$H_H_T)	comboDict[$flip_coin]="HHT"
			h_h_t_win=$(($h_h_t_win+1))
			;;
		$H_T_H)	comboDict[$flip_coin]="HTH"
			h_t_h_win=$(($h_t_h_win+1))
			;;
		$T_H_H)	comboDict[$flip_coin]="THH"
			t_h_h_win=$(($t_h_h_win+1))
			;;
		$H_T_T)	comboDict[$flip_coin]="HTT"
			h_t_t_win=$(($h_t_t_win+1))
			;;
		$T_T_H)	comboDict[$flip_coin]="TTH"
			t_t_h_win=$(($t_t_h_win+1))
			;;
		$T_H_T)	comboDict[$flip_coin]="THT"
			t_h_t_win=$(($t_h_t_win+1))
			;;
		*)	comboDict[$flip_coin]="TTT"
			t_t_t_win=$(($t_t_t_win+1))
			;;
	esac
done
echo "All coin combination " ${comboDict[@]}
echo "All keys of coin combination " ${!comboDict[@]}

percentDict[1]=`awk "BEGIN { print $h_win/$NUM_OF_FLIPS*100 }"`
percentDict[2]=`awk "BEGIN { print $t_win/$NUM_OF_FLIPS*100 }"`
percentDict[3]=`awk "BEGIN { print $h_h_win/$NUM_OF_FLIPS*100 }"`
percentDict[4]=`awk "BEGIN { print $h_t_win/$NUM_OF_FLIPS*100 }"`
percentDict[5]=`awk "BEGIN { print $t_h_win/$NUM_OF_FLIPS*100 }"`
percentDict[6]=`awk "BEGIN { print $t_t_win/$NUM_OF_FLIPS*100 }"`
percentDict[7]=`awk "BEGIN { print $h_h_h_win/$NUM_OF_FLIPS*100 }"`
percentDict[8]=`awk "BEGIN { print $h_h_t_win/$NUM_OF_FLIPS*100 }"`
percentDict[9]=`awk "BEGIN { print $h_t_h_win/$NUM_OF_FLIPS*100 }"`
percentDict[10]=`awk "BEGIN { print $t_h_h_win/$NUM_OF_FLIPS*100 }"`
percentDict[11]=`awk "BEGIN { print $h_t_t_win/$NUM_OF_FLIPS*100 }"`
percentDict[12]=`awk "BEGIN { print $t_t_h_win/$NUM_OF_FLIPS*100 }"`
percentDict[13]=`awk "BEGIN { print $t_h_t_win/$NUM_OF_FLIPS*100 }"`
percentDict[14]=`awk "BEGIN { print $t_t_t_win/$NUM_OF_FLIPS*100 }"`

echo "Combination percentage " ${percentDict[@]}
echo "Keys of Combination percentage " ${!percentDict[@]}

for (( i=1; i<=14; i++ ))
do
	percentArr[$i]=${percentDict[$i]}
done

for (( i=1; i<=14; i++ ))
do
	for (( j=$(($i+1)); j<=14; j++ ))
	do
		if (( $(awk 'BEGIN {print ('${percentArr[$i]}' >= '${percentArr[$j]}')}') ))
		then
			temp=${percentArr[$i]}
			percentArr[$i]=${percentArr[$j]}
			percentArr[$j]=$temp
		fi
	done
done
echo "Sorted combination percentage :" ${percentArr[@]}

max=0
for (( i=1; i<=14; i++ ))
do
	if (( $(awk 'BEGIN {print ('${percentDict[$i]}' > '$max')}') ))
	then
		max=${percentDict[$i]}
	fi
done
for (( i=1; i<=14; i++ ))
do
	if (( $(awk 'BEGIN {print ('${percentDict[$i]}' == '$max')}') ))
	then
		echo "Winning combination : ${comboDict[$i]} with $max %."
	fi
done
