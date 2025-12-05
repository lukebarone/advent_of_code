#!/usr/bin/env bash
# Part 2 AoC 2025 Day 2

# Input: ranges, separated by hyphens, and each range seperated by commas
# Invalid IDs to find are for any sequence of digits repeated at least twice
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
        for ((checking_id_length = 1; checking_id_length < (id_half_size + 1); checking_id_length++)) {
            # Since it's a variable length we need to check for now, but still up to half the length
            
            # Check if id length we're currently on could be divisible by the actual ID length
            if [ $(( id_size % checking_id_length )) -ne 0 ]; then
                continue
            fi
            
            # Check if half the ID is the same (2 elements)
            if [ "${id:0:checking_id_length}" == "${id:checking_id_length}" ]; then
                echo "INVALID ID: $id"
                running_total=$(( running_total + id ))
                continue
            fi
        }
        # Check odd elements 
        if [ "$id_size" -eq 3 ] ; then
            if [ "${id:0:1}" != "${id:1:1}" ] || [ "${id:1:1}" != "${id:2:1}" ]; then
                continue
            fi
            echo "INVALID ID: $id"
            running_total=$(( running_total + id ))
            continue
        fi
        # Skipping 4-length, as that would have been caught above with halving
        
        if [ "$id_size" -eq 5 ] ; then
            if [ "${id:0:1}" != "${id:1:1}" ] || [ "${id:0:1}" != "${id:2:1}" ] ||
            [ "${id:0:1}" != "${id:3:1}" ] || [ "${id:0:1}" != "${id:4:1}" ] ; then
                continue
            fi
            echo "INVALID ID: $id"
            running_total=$(( running_total + id ))
            continue
        fi

        if [ "$id_size" -eq 6 ] ; then
            # Already have all-same-digits covered due to halving up top;
            # check for pairs and groups of three
            if [ "${id:0:3}" == "${id:3:3}" ] ; then
                # Caught by halving up top
                continue
            elif [ "${id:0:2}" == "${id:2:2}" ] && [ "${id:0:2}" == "${id:4:2}" ]; then
                # First two digits match second two, and match third set,
                # but the first and second halves do not (since they're
                # counted above)
                echo "6-digit INVALID ID: $id"
                running_total=$(( running_total + id ))
                continue
            fi
            
        fi
        if [ "$id_size" -eq 7 ] ; then
            if [ "${id:0:1}" != "${id:1:1}" ] || [ "${id:0:1}" != "${id:2:1}" ] ||
            [ "${id:0:1}" != "${id:3:1}" ] || [ "${id:0:1}" != "${id:4:1}" ] ||
            [ "${id:0:1}" != "${id:5:1}" ] || [ "${id:0:1}" != "${id:6:1}" ] ; then
                continue
            fi
            echo "INVALID ID: $id"
            running_total=$(( running_total + id ))
            continue
        fi
        if [ "$id_size" -eq 9 ] ; then
            if [ "${id:0:1}" == "${id:1:1}" ] && [ "${id:0:1}" == "${id:2:1}" ] &&
            [ "${id:0:1}" == "${id:3:1}" ] && [ "${id:0:1}" == "${id:4:1}" ] &&
            [ "${id:0:1}" == "${id:5:1}" ] && [ "${id:0:1}" == "${id:6:1}" ] &&
            [ "${id:0:1}" == "${id:7:1}" ] && [ "${id:0:1}" == "${id:8:1}" ] ; then
            # All digits the same
                echo "9-digit INVALID ID: $id"
                running_total=$(( running_total + id ))
                continue
            fi
            if [ "${id:0:3}" == "${id:3:3}" ] && [ "${id:0:3}" == "${id:6:3}" ] ; then
            # Three sets of 3 digits
                echo "9-digit INVALID ID: $id"
                running_total=$(( running_total + id ))
                continue
            fi
        fi
        if [ "$id_size" -eq 10 ] ; then
            # All same and groups of 5 would be caught above. Check for pairs
            if [ "${id:0:2}" == "${id:2:2}" ] && [ "${id:0:2}" == "${id:4:2}" ] &&
               [ "${id:0:2}" == "${id:6:2}" ] && [ "${id:0:2}" == "${id:8:2}" ] ; then
            # Five sets of 2 digits
                echo "10-digit INVALID ID: $id"
                running_total=$(( running_total + id ))
                continue
            fi
        fi
    }
    
done < "${TEMP_FILE}"

echo "Final answer: ${running_total}"
# Example target answer: 4174379265