#!/bin/bash

GCCPATH=/usr/bin/gcc

if [ -f "$GCCPATH" ]; then
	gcc -v 2> >(grep "gcc version" > gcc.txt)
	man gcc >> gcc.txt
else
	echo "Can't find gcc in $GCCPATH"
	exit 0
fi

