#!/usr/bin/env bash
# Part 1 AoC 2025 Day 3

# Input: power banks, one per line, of integers >0 and <10
# Goal: Flip on the two individual batteries that will produce the highest
# output, and output the total "joltage"
running_total=0
TEMP_FILE="$(mktemp)"
cleanup () {
    rm "${TEMP_FILE}"
}
trap cleanup EXIT

# Create temporary file to work through
cp input.txt "$TEMP_FILE"

# Read each field, and get the low and high number in each range
while read -r bank; do
    bank_size="${#bank}"
    high_digit_position=0
    current_high_digit="${bank:high_digit_position:1}" # Start with the first number as the highest
    for ((number = 1; number < (bank_size - 1); number++)) {
        if [ "${bank:number:1}" -gt "${current_high_digit}" ]; then
            current_high_digit="${bank:number:1}"
            high_digit_position="${number}"
        fi
        
    }
    echo "${bank} - High digit is ${current_high_digit} at position ${high_digit_position}"
    # Now, check for the highest digit after
    next_high_digit=0
    next_high_digit_position=0
    for ((number = (high_digit_position + 1); number < bank_size; number++)) {
        if [ "${bank:number:1}" -gt "${next_high_digit}" ]; then
            next_high_digit="${bank:number:1}"
            next_high_digit_position="${number}"
        fi
        
    }
    echo "${bank} - NEXT High digit is ${next_high_digit} at position ${next_high_digit_position}"
    high_power=$((current_high_digit * 10 + next_high_digit))
    echo "${bank} - Highest 2-digit is ${high_power}"
    running_total=$((running_total + high_power))
done < "${TEMP_FILE}"

echo "Final answer: ${running_total}"
# Example target: 357