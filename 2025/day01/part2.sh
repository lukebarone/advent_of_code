#!/usr/bin/env bash
# Part 2 AoC 2025 Day 1

current_position=50
movement=0
count_of_zeroes=0

while read -r line; do
    movement="${line:1}"
    # Move the dial in the direction
    if [ "${line:0:1}" == "L" ]; then
        for ((i = 0; i < movement; i++)); do
            current_position=$((current_position - 1))
            if [ $current_position == 0 ]; then
                ((count_of_zeroes++))
            fi
            if [ $current_position -lt 0 ]; then
                current_position=$((current_position + 100))
            fi
        done
    else
        for ((i = 0; i < movement; i++)); do
            current_position=$((current_position + 1))
            if [ $current_position == 100 ]; then
                current_position=$((current_position - 100))
            fi
            if [ $current_position == 0 ]; then
                ((count_of_zeroes++))
            fi
        done
    fi

    echo -e "${count_of_zeroes} \t ${line:0:1} ${movement} \t->\t ${current_position}"
done < input.txt
echo "Final count: ${count_of_zeroes}"
