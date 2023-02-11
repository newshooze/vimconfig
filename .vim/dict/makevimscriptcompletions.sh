#!/bin/bash
###################################################
# Create a dictionary of completion
# words for vim script files
# set dictionary=OUTFILE
# set complete+=k
DOCDIR=/usr/share/vim/vim90/doc/
OUTFILE=vimscriptcompletions.txt

# Grab every word from all vim help files
grep -h -o -E '\w+' "$DOCDIR"*.txt | sort -u > "$OUTFILE"
# Remove words that are less than 4 letters
grep '^[A-Za-z]\{4\}' "$OUTFILE" > temp.tmp
sort -u temp.tmp > "$OUTFILE"
rm temp.tmp
