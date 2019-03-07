#!/bin/bash
# html2text is required
# Run this file inside vim's doc directory. It's usually ~/.vim/doc
# Change the variable DOCPATH below to the csound html documentation 

command -v html2text >/dev/null 2>&1 || { echo >&2 "html2text is required. Exiting."; exit 1; }

DOCPATH=/usr/share/doc/csound-doc/html
DOCFILES=$(ls -1 $DOCPATH/*.html)
VIMVERSION=7.4
HELPFILE=csound.txt
TAGFILE=tags
USEMODELINE=yes # Default to yes any other value is no.
FILEINDEX=0
FILECOUNT=$(echo $DOCFILES | wc -w)

[ -f $HELPFILE ] && rm $HELPFILE

echo -e "*$HELPFILE*\tfor Vim version $VIMVERSION\tLast Change: $(date +'%Y %B %d')" >> $HELPFILE
echo "" >> $HELPFILE
echo "                     CSOUND REFERENCE MANUAL" >> $HELPFILE
echo "" >> $HELPFILE
for FILE in $DOCFILES
  do
		let "FILEINDEX++"
		printf "Processing file %s of %s\r" $FILEINDEX $FILECOUNT
    filename=${FILE##*/}
    filename=${filename%.html}
    echo "==============================================================================" >> $HELPFILE
    echo "                                                       *$filename*" >> $HELPFILE
    echo "" >> $HELPFILE
    sed 's/citetitle">/citetitle">|/g' $FILE | sed 's/<\/em><\/a>/|<\/em><\/a>/g' | html2text | tail -n +11 | head -n -3 | tr -cd '[:print:][:cntrl:]' >> $HELPFILE
    echo "" >> $HELPFILE
  done
[ $USEMODELINE == "yes" ] && echo "vim:tw=78:ts=8:ft=help:norl:" >> $HELPFILE

echo 
echo "Fixing broken links..."

# TODO fix more broken links
sed -i 's/Real-time_Audio/Real_time_Audio/g' $HELPFILE
sed -i 's/\*CommandFlags\*/*Command_Line_Flags*/g' $HELPFILE
sed -i 's/\*OrchKvar\*/*global_variable* *OrchKvar*/g' $HELPFILE
sed -i 's/\*UsingRealTime\*/*Real_time_Audio*/g' $HELPFILE
sed -i 's/\*Zerodbfs\*/*0dbfs* *Zerodbfs*/g' $HELPFILE
sed -i 's/\*ampdbfs\*/*ampdbfs* *ampdbfs()*/g' $HELPFILE
sed -i 's/\*assign\*/*assignments*/g' $HELPFILE
sed -i 's/\*instr\*/*instr_statement* *instr*/g' $HELPFILE

#delete the line referencing xxx.csd file + 1 more line	
sed -i -e '/Here is an example.*It uses the file.*$/,+1d' $HELPFILE

# This places csound code blocks between '>' and '<'. vim will syntax highlight this block
sed -i '/<CsoundSynthesizer>/,/<\/CsoundSynthesizer>/s/^/ /g' $HELPFILE
sed -i 's/^ <CsoundSynthesizer>/>\n <CsoundSynthesizer>/g' $HELPFILE 
sed -i 's/^ <\/CsoundSynthesizer>$/ <\/CsoundSynthesizer>\n</g' $HELPFILE

echo "Writing file $HELPFILE."
echo "Writing file $TAGFILE."

# Run vim to create tags for all .txt files in current directory and quit.
vim -c "helptags ./ | q"

echo "Done."

