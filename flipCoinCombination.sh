#!/bin/bash -x
H=1
flip_coin=$((RANDOM%2))

if [ $flip_coin -eq $H ]
then
	echo "Heads"
else
	echo "Tails"
fi
