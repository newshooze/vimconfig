#!/bin/bash

FILEINDEX=0
DOCDIR=/usr/share/man/man3
VIMVERSION=7.4
FILECOUNT=$(echo "$DOCDIR"/*.gz | wc -w)
for FILE in /usr/share/man/man3/*.gz; do
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
  echo "*$BASENAME*" >> "$HELPFILE"
  echo "" >> "$HELPFILE"
  #man $BASENAME | sed '1d;$d' | sed '0,/^Example/s//Example >/' >> $HELPFILE
  man "$BASENAME" | sed '1d;$d' | sed 's/\(^Example[+]\?\)/\1 >/g' >> "$HELPFILE"
  sed -i 's/^\([A-Z].*\)/\1 ~/g' "$HELPFILE"
  echo >> "$HELPFILE"
  #echo "" >> "$HELPFILE"
#  [ "$FILEINDEX" -gt 10 ] && exit
done
echo "Generating tag file..."
vim -c "helptags ./ | q"
echo "done"
