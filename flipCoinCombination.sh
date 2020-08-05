#!/bin/bash -x
H=1
NUM_OF_FLIPS=30

h_win=0
t_win=0

declare -A singletDict
for (( i=1; i<=$NUM_OF_FLIPS; i++ ))
do
   flip_coin=$((RANDOM%2))
   case $flip_coin in
		$H)	singletDict[$i]="H"
				h_win=$(($h_win+1))
				;;
		*)	singletDict[$i]="T"
			t_win=$(($t_win+1))
			;;
	esac
done
echo ${singletDict[@]}
percent_h=`awk "BEGIN { print $h_win/$NUM_OF_FLIPS*100 }"`
percent_t=`awk "BEGIN { print $t_win/$NUM_OF_FLIPS*100 }"`
