#!/usr/bin/env bash
# Part 1 AoC 2025 Day 1

current_position=50
movement=0
count_of_zeroes=0
while read line; do
    movement="${line:1}"
    if [ "${line:0:1}" == "L" ]; then
        current_position=$((current_position - movement))
        while [ $current_position -lt 0 ]; do
            ((current_position += 100))
        done
    else
        current_position=$((current_position + movement))
        while [ $current_position -ge 100 ]; do
            ((current_position -= 100))
        done
    fi
    if [ $current_position -eq 0 ]; then
        ((count_of_zeroes++))
    fi
    echo -e "${count_of_zeroes} \t ${movement} \t ${current_position}"
done < input.txt
echo "Final count: ${count_of_zeroes}"