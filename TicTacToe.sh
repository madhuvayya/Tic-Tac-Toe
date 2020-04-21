#!/bin/bash

NUM_OF_ROWS=3
NUM_OF_COLMS=3
NUM_OF_POS=$(($NUM_OF_ROWS*$NUM_OF_COLMS))
HEAD=1
TAIL=0

computerLtr=""
yourLtr=""

turn=""

position=0
numOfTurns=1

declare -A board

resetBoard(){
	for((i=1;i<=$NUM_OF_POS;i++))
	do
		board[$i]="-"
	done
}

findLetterAssigned(){
	rand=$((RANDOM%2))
	if [ $rand = 0 ]
	then
		computerLtr="o"
		yourLtr="x"
	else
		computerLtr="x"
		yourLtr="o"
	fi
	echo Computer letter: $computerLtr
	echo Letter assigned to you: $yourLtr
}

whoPlaysFirst(){
	rand=$((RANDOM%2))
	if [ $rand -eq $HEAD ]
	then
		echo computer won toss
		turn="computer"
	else
		echo you won toss
		turn="your"
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
			echo ${board[$((1+$t))]}
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

	if [ $1 = $computerLtr ]
	then
		player="computer"
	else
		player="you"
	fi

	printBoard
	echo Winner is $player
	exit
}

checkTie(){

	if [ $numOfTurns -eq $NUM_OF_POS ]
	then
		echo game is tie
		exit
	fi
}

checkWinnerTie(){

	checkRows

	checkColms

	checkDiag

	checkTie
}

rowPos(){
	for((i=0;i<$NUM_OF_ROWS;i++))
	do
		t=$((3*$i))

		a=${board[$((1+$t))]}
		b=${board[$((2+$t))]}
		c=${board[$((3+$t))]}

		if [[ $a = $1 && $b = $1 && $c = "-" ]]
		then
			position=$((3+$t))
			break
		elif [[ $b = $1 && $c = $1 && $a = "-" ]]
		then
			position=$((1+$t))
			break
		elif [[ $a = $1 && $c = $1 && $b = "-" ]]
		then
			position=$((2+$t))
			break
		fi
	done
}

colmPos(){
	for((i=0;i<$NUM_OF_COLMS;i++))
	do
		a=${board[$((1+$i))]}
		b=${board[$((4+$i))]}
		c=${board[$((7+$i))]}

		if [[ $a = $1 && $b = $1 && $c = "-" ]]
		then
			position=$((7+$i))
			break
		elif [[ $b = $1 && $c = $1 && $a = "-" ]]
		then
			position=$((1+$i))
			break
		elif [[ $a = $1 && $c = $1 && $b = "-" ]]
		then
			position=$((4+$i))
			break
		fi
	done
}

diagPos(){
	for((i=0;i<2;i++))
	do
		t=$((2*$i))
		a=${board[$((1+$t))]}
		b=${board[$((5))]}
		c=${board[$((9-$t))]}

		if [[ $a = $1 && $b = $1 && $c = "-" ]]
		then
			position=$((9-$t))
			break
		elif [[ $b = $1 && $c = $1 && $a = "-" ]]
		then
			position=$((1+$t))
			break
		elif [[ $a = $1 && $c = $1 && $b = "-" ]]
		then
			position=5
			break
		fi
	done
}

winOrBlockMove(){
	rowPos $1
	if [ $position -eq 0 ]
	then
		colmPos $1
		if [ $position -eq 0 ]
		then
	        	diagPos $1
		fi
	fi

}

cornersChoice(){
	for((i=0;i<2;i++))
	do
		if [ ${board[$(( 1 + 2*$i ))]} = "-" ]
		then
			position=$(( 1 + 2*$i ))
			break
		elif [ ${board[$(( 7 + 2*$i ))]} = "-" ]
		then
			position=$(( 7 + 2*$i ))
			break
		fi
	done
}

computerTurn(){

	winOrBlockMove $computerLtr
	if [ $position -eq 0 ]
	then
		winOrBlockMove $yourLtr
		if [ $position -eq 0 ]
		then
			cornersChoice
		fi
	fi
}

checkValidPosition(){
	if [  ${board[$1]} != "-" ]
	then
		echo "entered position is already occupied"
		valid="false"
	else
		valid="true"
	fi
}

initilize(){
	resetBoard

	findLetterAssigned

	whoPlaysFirst
}

play(){
	while [ $numOfTurns -le $NUM_OF_POS  ]
	do
		if [ $turn = computer ]
		then
			echo It is computer turn
			computerTurn
			checkValidPosition $position
			board[$position]=$computerLtr
			((numOfTurns++))
			turn="your"
		else
			echo It is you turn
			echo "enter your position(1-9)"
			read position
			checkValidPosition $position
			if [ $valid = true ]
			then
				board[$position]=$yourLtr
				((numOfTurns++))
				turn="computer"
			fi
		fi

		printBoard
		checkWinnerTie
		position=0
	done
}

start(){

	initilize
	play
}

start
