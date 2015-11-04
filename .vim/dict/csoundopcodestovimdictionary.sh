#!/bin/bash
# This creates a csound dictionary for use in vim
BLANKLINE=$( csound --list-opcodes 2<&1 | grep -n -G "^$" | awk -F : '{print $1}' )
echo "$BLANKLINE"
csound --list-opcodes 2<&1 | tail -n +$BLANKLINE | grep -R -o -h -P "[a-zA-Z_0-9]*" > csd 

