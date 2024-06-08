#!/bin/bash

FILEINDEX=0
PAGEWIDTH=78 
DOCDIR=/usr/share/man/man1  # FIXME
VIMVERSION=7.4
HELPFILE=man1.txt

[ -f "$HELPFILE" ] && rm "$HELPFILE"

FILECOUNT=$(echo "$DOCDIR"/*.gz | wc -w)
for FILE in $DOCDIR/*.gz; do
  FILENAME=${FILE##*/}
  BASENAME=$(echo "$FILENAME" | sed 's/\..*$//g')
  BASENAMELENGTH=$(echo "$BASENAME" | wc -c)
  OFFSET=$(( "$PAGEWIDTH" - "$BASENAMELENGTH" ))
#  HELPFILE="$BASENAME".txt
  # Touch or empty the file
#  echo -n "" > "$HELPFILE"
  let $((FILEINDEX++))
  printf "Processing file %s of %s\r" "$FILEINDEX" "$FILECOUNT"
  echo "===============================================================================" >> "$HELPFILE"
  for (( s=0; s<$OFFSET; s++ ))
  do
    echo -n " " >> "$HELPFILE"
  done
  echo "*$BASENAME*" >> "$HELPFILE"
  # This works best if the terminal is set to a width of 80 characters.
  # man formats output based on terminal width
  TEMPFILE=TEMP.TMP
  echo "" > "$TEMPFILE"
  man "$BASENAME" | sed '1d;$d' | sed 's/\(^Example[+]\?\)/\1 >/g' >> "$TEMPFILE"
  # Put a space and tilde after paragraph headings.
  # Vim highlights these.
  sed -i 's/^\([A-Z].*\)/\1 ~/g' "$TEMPFILE"
  cat "$TEMPFILE" >> "$HELPFILE"
  echo >> "$HELPFILE"
done
echo "Generating tag file..."
vim -c "helptags ./ | q"
grep '^[A-Za-z]\{4\}' tags > "$TEMPFILE"
LC_COLLATE=C sort -u "$TEMPFILE" > tags
rm "$TEMPFILE"
echo "done"
