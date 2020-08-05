#!/bin/bash -x
H_H_H=1
H_H_T=2
H_T_H=3
T_H_H=4
H_T_T=5
T_T_H=6
T_H_T=7

NUM_OF_FLIPS=30

h_h_h_win=0
h_h_t_win=0
h_t_h_win=0
t_h_h_win=0
h_t_t_win=0
t_t_h_win=0
t_h_t_win=0
t_t_t_win=0

declare -A tripletDict
declare -A percentDict

for (( i=1; i<=$NUM_OF_FLIPS; i++ ))
do
	flip_coin=$((RANDOM%8))
	case $flip_coin in
		$H_H_H)	tripletDict[$i]="HHH"
					h_h_h_win=$(($h_h_h_win+1))
					;;
		$H_H_T)	tripletDict[$i]="HHT"
					h_h_t_win=$(($h_h_t_win+1))
					;;
		$H_T_H)	tripletDict[$i]="HTH"
					h_t_h_win=$(($h_t_h_win+1))
					;;
		$T_H_H)	tripletDict[$i]="THH"
					t_h_h_win=$(($t_h_h_win+1))
					;;
		$H_T_T)	tripletDict[$i]="HTT"
					h_t_t_win=$(($h_t_t_win+1))
					;;
		$T_T_H)	tripletDict[$i]="TTH"
					t_t_h_win=$(($t_t_h_win+1))
					;;
		$T_H_T)	tripletDict[$i]="THT"
					t_h_t_win=$(($t_h_t_win+1))
					;;
		*)	tripletDict[$i]="TTT"
			t_t_t_win=$(($t_t_t_win+1))
			;;
	esac
done
echo "Triplet combination " ${tripletDict[@]}
percentDict[HHH]=`awk "BEGIN { print $h_h_h_win/$NUM_OF_FLIPS*100 }"`
percentDict[HHT]=`awk "BEGIN { print $h_h_t_win/$NUM_OF_FLIPS*100 }"`
percentDict[HTH]=`awk "BEGIN { print $h_t_h_win/$NUM_OF_FLIPS*100 }"`
percentDict[THH]=`awk "BEGIN { print $t_h_h_win/$NUM_OF_FLIPS*100 }"`
percentDict[HTT]=`awk "BEGIN { print $h_t_t_win/$NUM_OF_FLIPS*100 }"`
percentDict[TTH]=`awk "BEGIN { print $t_t_h_win/$NUM_OF_FLIPS*100 }"`
percentDict[THT]=`awk "BEGIN { print $t_h_t_win/$NUM_OF_FLIPS*100 }"`
percentDict[TTT]=`awk "BEGIN { print $t_t_t_win/$NUM_OF_FLIPS*100 }"`

echo "Triplet keys " ${!percentDict[@]}
echo "Triplet combo percentage " ${percentDict[@]}
