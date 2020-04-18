#!/bin/bash

NUM_OF_POS=9
HEAD=1
TAIL=0

player1=""
player2=""

declare -A board

resetBoard(){
	for((i=1;i<=$NUM_OF_POS;i++))
	do
		board[$i]=-
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

printBoard(){

	echo -e  "\n  BOARD"
	echo  ${board[1]} \| ${board[2]} \| ${board[3]}
	echo  ---------
	echo  ${board[4]} \| ${board[5]} \| ${board[6]}
	echo  ---------
	echo  ${board[7]} \| ${board[8]} \| ${board[9]}
}

resetBoard

findLetterAssigned

whoPlaysFirst

printBoard
