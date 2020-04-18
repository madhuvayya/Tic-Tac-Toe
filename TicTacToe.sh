#!/bin/bash -x

declare -A board

for((i=0;i<9;i++))
do
	board[$i]=-
done

echo ${board[@]}
