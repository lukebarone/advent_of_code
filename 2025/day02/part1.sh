#!/usr/bin/env bash
# Part 1 AoC 2025 Day 2

# Input: ranges, separated by hyphens, and each range seperated by commas
# Invalid IDs to find are for any sequence of digits repeated twice
# No leading zeroes in inputs
low=""
high=""
running_total=0
TEMP_FILE="$(mktemp)"
cleanup () {
    rm "${TEMP_FILE}"
}
trap cleanup EXIT

# Create temporary file to work through
cp input.txt "$TEMP_FILE"

# Split fields into different lines
sed -ie 's/,/\n/g' "${TEMP_FILE}"

# Read each field, and get the low and high number in each range
while IFS='-' read -r low high; do
    for ((id = low; id < (high + 1); id++)) {
        id_size="${#id}"
        id_half_size="$(( id_size / 2 ))"
        if [ $(( id_size % 2 )) -eq 0 ]; then
            # Check that the length of the value is an even number
            if [ "${id:0:id_half_size}" == "${id:id_half_size}" ]; then
                echo "INVALID ID: $id"
                running_total=$(( running_total + id ))
            fi
        fi
    }
done < "${TEMP_FILE}"

echo "Final answer: ${running_total}"