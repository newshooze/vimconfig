#!/bin/bash

FILEINDEX=0
DOCDIR=/usr/share/man/man3  # FIXME
VIMVERSION=7.4
FILECOUNT=$(echo "$DOCDIR"/*.gz | wc -w)
for FILE in $DOCDIR/*.gz; do
echo "$FILE"
  FILENAME=${FILE##*/}
  BASENAME=$(echo "$FILENAME" | sed 's/\..*$//g')
  BASENAMELENGTH=$(echo "$BASENAME" | wc -c)
  OFFSET=$(( 78 - "$BASENAMELENGTH" ))
  HELPFILE="$BASENAME".txt
  # Touch or empty the file
  echo -n "" > "$HELPFILE"
  let $((FILEINDEX++))
  printf "Processing file %s of %s\r" "$FILEINDEX" "$FILECOUNT"
  echo "*$HELPFILE*" >> "$HELPFILE"
  echo "===============================================================================" >> "$HELPFILE"
  for (( s=0; s<$OFFSET; s++ ))
  do
    echo -n " " >> "$HELPFILE"
  done
  # This works best if the terminal is set to a width of 80 characters.
  # man formats output based on terminal width
  man "$BASENAME" | sed '1d;$d' | sed 's/\(^Example[+]\?\)/\1 >/g' >> "$HELPFILE"
  # Put a space and tilde after paragraph headings.
  # Vim highlights these.
  sed -i 's/^\([A-Z].*\)/\1 ~/g' "$HELPFILE"
  echo >> "$HELPFILE"
done
echo "Generating tag file..."
vim -c "helptags ./ | q"
echo "done"
