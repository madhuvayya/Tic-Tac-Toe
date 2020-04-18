#!/bin/bash -x

NUM_OF_POS=9

player1=""
player2=""

declare -A board

for((i=0;i<$NUM_OF_POS;i++))
do
	board[$i]="-"
done

player1="o"

if [ $player1 = x ]
then
	player2="o"
else
	player2="x"
fi

echo letter assigned: $player2

