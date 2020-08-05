#!/bin/bash -x

H_H=1
H_T=2
T_H=3
NUM_OF_FLIPS=30

h_h_win=0
h_t_win=0
t_h_win=0
t_t_win=0

declare -A doubletDict
declare -A percentDict

for (( i=1; i<=$NUM_OF_FLIPS; i++ ))
do
	flip_coin=$((RANDOM%4))
	case $flip_coin in
		$H_H)	doubletDict[$i]="HH"
				h_h_win=$(($h_h_win+1))
				;;
		$H_T)	doubletDict[$i]="HT"
				h_t_win=$(($h_t_win+1))
				;;
		$T_H)	doubletDict[$i]="TH"
				t_h_win=$(($t_h_win+1))
				;;
		*)	doubletDict[$i]="TT"
			t_t_win=$(($t_t_win+1))
			;;
	esac
done
echo ${doubletDict[@]}
percentDict[HH]=`awk "BEGIN { print $h_h_win/$NUM_OF_FLIPS*100 }"`
percentDict[HT]=`awk "BEGIN { print $h_t_win/$NUM_OF_FLIPS*100 }"`
percentDict[TH]=`awk "BEGIN { print $t_h_win/$NUM_OF_FLIPS*100 }"`
percentDict[TT]=`awk "BEGIN { print $t_t_win/$NUM_OF_FLIPS*100 }"`

echo ${!percentDict[@]}
echo ${percentDict[@]}
