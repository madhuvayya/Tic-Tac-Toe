#!/bin/bash -x

NUM_OF_POS=9
HEAD=1
TAIL=0

player1=""
player2=""

declare -A board

resetBoard(){
	for((i=0;i<$NUM_OF_POS;i++))
	do
		board[$i]="-"
	done
}

findLetterAssigned(){
	echo enter plyer1 choice:
	read player1

	if [ $player1 = x ]
	then
		player2="o"
	else
		player2="x"
	fi

	echo letter assigned to player2: $player2
}

whoPlaysFirst(){

	rand=$((RANDOM%2))

	if [ $rand -eq $HEAD ]
	then
		echo player1
	else
		echo player2
	fi
}

resetBoard

findLetterAssigned

whoPlaysFirst
