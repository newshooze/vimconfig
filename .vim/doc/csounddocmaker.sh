#!/bin/bash
# html2text is required
# Run this file inside vim's doc directory. It's usually ~/.vim/doc
# Change the variable DOCFILES below to the csound html documentation 

command -v html2text >/dev/null 2>&1 || { echo >&2 "html2text is required. Exiting."; exit 1; }

DOCFILES=/usr/share/doc/csound-doc/html/*.html
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
sed -i 's/\*ScoreGenRef\*/*GEN* *ScoreGenRef* *GEN_routine_overview*/g' $HELPFILE
sed -i 's/\*UsingRealTime\*/*Real_time_Audio*/g' $HELPFILE
sed -i 's/\*Zerodbfs\*/*0dbfs* *Zerodbfs*/g' $HELPFILE
sed -i 's/\*ampdbfs\*/*ampdbfs* *ampdbfs()*/g' $HELPFILE
sed -i 's/\*assign\*/*assignments*/g' $HELPFILE
sed -i 's/\*instr\*/*instr* *instr_statement*/g' $HELPFILE

# skip these if they conflict with some single letter tags
sed -i 's/\*f\*/*f* *f_statement*/g' $HELPFILE
sed -i 's/\*m\*/*m* *m_statement*/g' $HELPFILE
sed -i 's/\*n\*/*n* *n_statement*/g' $HELPFILE
sed -i 's/\*r\*/*r* *r_statement*/g' $HELPFILE
sed -i 's/\*s\*/*s* *s_statement*/g' $HELPFILE
sed -i 's/\*t\*/*t* *t_statement*/g' $HELPFILE
sed -i 's/\*greaterthan\*/*>* *greaterthan*/g' $HELPFILE
sed -i 's/\*greaterequal\*/*>=* *greaterequal*/g' $HELPFILE
sed -i 's/\*lessethan\*/*<* *lessthan*/g' $HELPFILE
sed -i 's/\*lessequal\*/*<=* *lessequal*/g' $HELPFILE
sed -i 's/\*equals\*/*==* *equals*/g' $HELPFILE
sed -i 's/\*notequal\*/*!=* *notequal*/g' $HELPFILE

# delete the line referencing xxx.csd file + 1 more line	
sed -i -e '/Here is an example.*It uses the file.*$/,+1d' $HELPFILE
# delete additional references to xxx.csd + 1 more line
sed -i -e '/Here is another example.*$/,+1d' $HELPFILE
# delete some embedded xml
sed -i -e '/<?xml version=.*$/,+21d' $HELPFILE

# This places csound code blocks between '>' and '<'. vim will syntax highlight this block
sed -i '/<CsoundSynthesizer>/,/<\/CsoundSynthesizer>/s/^/ /g' $HELPFILE # code blocks require white space at the beginning of each line
sed -i 's/^ <CsoundSynthesizer>/>\n <CsoundSynthesizer>/g' $HELPFILE # add '>' and a newline to lines before <Csou...
sed -i 's/^ <\/CsoundSynthesizer>$/ <\/CsoundSynthesizer>\n</g' $HELPFILE # add '<' after </Csou..

echo "Writing file $HELPFILE."
echo "Writing file $TAGFILE."

# Run vim to create tags for all .txt files in current directory and quit.
vim -c "helptags ./ | q"

echo "Done."

