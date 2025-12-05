#!/usr/bin/env bash
# Part 1 AoC 2025 Day 3

# Input: power banks, one per line, of integers >0 and <10
# Goal: Flip on the twelve individual batteries that will produce the highest
# output, and output the total "joltage" with the 12 digit numbers
running_total=0
TEMP_FILE="$(mktemp)"
cleanup () {
    rm "${TEMP_FILE}"
}
trap cleanup EXIT

# Create temporary file to work through
cp example.txt "$TEMP_FILE"

# Read each field, and get the low and high number in each range
while read -r bank; do
    bank_size="${#bank}"
    high_digit_position=0
    bank_array_12_largest=()
    # Up to 100 digits, but only need 12
    digits_counted=0
    for ((index=0; index < bank_size; index++)) {
        echo "DEBUG - Index=${index}; value=${bank:index:1}"
        for ((number=9; number > 0; number-- )) {
            
            if [ "${bank:index:1}" == "${number}" ]; then
                echo "${bank} - Found large number ${number} at index ${index}"
                bank_array_12_largest[index]=$number
            fi
            
            if [ "${#bank_array_12_largest[@]}" -eq 12 ]; then
                break
            fi
            
        }
        echo "DEBUG - Running number is ${bank_array_12_largest[@]}"
    }
    #running_total=$((running_total + high_power))
done < "${TEMP_FILE}"

echo "Final answer: ${running_total}"
# Example target: 3121910778619