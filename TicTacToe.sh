#!/bin/bash

NUM_OF_ROWS=3
NUM_OF_COLMS=3
NUM_OF_POS=$(($NUM_OF_ROWS*$NUM_OF_COLMS))
HEAD=1
TAIL=0

player1=""
player2=""

numOfTurns=0

declare -A board

resetBoard(){
	for((i=1;i<=$NUM_OF_POS;i++))
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
		echo player1 won toss
	else
		echo player2 won toss
	fi
}

printBoard(){
	echo -e  "\n  BOARD"
	echo  ---------
	for((i=0;i<$NUM_OF_ROWS;i++))
	do
		t=$(($NUM_OF_COLMS*$i))
		echo  ${board[$((1+$t))]} \| ${board[$((2+$t))]} \| ${board[$((3+$t))]}
	  	echo  ---------
	done
}

checkRows(){
	for((i=0;i<$NUM_OF_ROWS;i++))
	do
		t=$((3*$i))
		if [[ ${board[$((1+$t))]} != "-" &&  ${board[$((1+$t))]} = ${board[$((2+$t))]} && ${board[$((2+$t))]} =  ${board[$((3+$t))]} ]]
		then
			winner ${board[$((1+$t))]}
		fi
	done
}

checkColms(){
	for((i=0;i<$NUM_OF_COLMS;i++))
	do
		if [[ ${board[$((1+$i))]} != "-" && ${board[$((1+$i))]} = ${board[$((4+$i))]} && ${board[$((4+$i))]} =  ${board[$((7+$i))]} ]]
		then
			winner ${board[$((1+$i))]}
		fi
	done
}

checkDiag(){
	if [[ ${board[1]} != "-" && ${board[1]} = ${board[5]} && ${board[5]} =  ${board[9]} ]]
	then
		winner ${board[1]}
	elif [[ ${board[3]} != - && ${board[3]} = ${board[5]} && ${board[5]} =  ${board[7]} ]]
	then
		winner ${board[3]}
	fi

}

winner(){

	if [ $1 = $player1 ]
	then
		player=$player1
	elif [ $1 = $player2 ]
	then
		player=$player2
	fi

	printBoard
	echo Winner is $player
	exit
}

checkTie(){
	temp=0
	for((i=1;i<=$NUM_OF_POS;i++))
	do
		if [ ${board[$i]} != "-" ]
		then
			((temp++))
		fi
	done

	if [ $temp -eq $NUM_OF_POS ]
	then
		echo game is tie
	else
		echo changeTurn
	fi
}

checkWinnerTie(){

	checkRows

	checkColms

	checkDiag

	checkTie
}

resetBoard

findLetterAssigned

whoPlaysFirst

checkWinnerTie
