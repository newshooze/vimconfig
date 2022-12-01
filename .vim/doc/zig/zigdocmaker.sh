#!/bin/bash
# 
# Finds all instances of `pub fn(...` recursively
# and creates a tags file for vim.
# root path is /usr/lib/zig or similar.
# cp -R /usr/lib/zig ~/.vim/doc/zig 
#
# TODO - Resolve Dir paths is a smarter way
# TODO - Implement this in zig
#
BASEDIR=~/.vim/doc/zig
FILESPROCESSED=0
FILECOUNT=$(find ./ -type f -name '*.zig' | wc -l)

generate_tag_files()
{
	FILE="$1"
	grep "pub fn [A-Za-z][A-Za-z0-9]*(.*" "$FILE" | while read STRING; do
		FUNCTIONNAME=$(echo "$STRING" | awk 'BEGIN{FS="fn "} {print $2}' | awk 'BEGIN{FS="("} {print $1}')
		cd $(dirname "$FILE")
		printf "$FUNCTIONNAME" >> tags
		printf "\t" >> tags
		printf "$FILE" >> tags
		printf "\t" >> tags
		printf "/pub fn $FUNCTIONNAME("	>> tags
		printf "\n" >> tags
		LC_ALL=C sort tags > FUCKFUCK && mv FUCKFUCK tags
	done
	let FILESPROCESSED=$FILESPROCESSED+1
	printf "Processing tag file %d of %d  -  %s                      \r" "$FILESPROCESSED" "$FILECOUNT" $(basename "$FILE")
}

delete_tag_files()
{
	printf "Deleting tag files in all subdirectories...\r"
	find $(pwd)/ -type d | while read tagsdir; do cd $(dirname "$tagsdir"); rm "$tagsdir/"tags 2>/dev/null ; done
	printf "==================== DONE ======================\n"
}

print_usage()
{
  printf "usage: " 
	printf $(basename $BASH_SOURCE) 
	printf " [OPTIONS]\n"
	printf "  -h --help        Show this help.\n"
	printf "  -t --tags        Recursively generate tags. Tags are deleted first.\n"
	printf "  -d --delete      Recursively delete tags. ( No Warnings! )\n"
	exit 0
}
# Check for command line arguments
if ([ "$1" == "-h" ] || [ "$1" == "--help" ] || [ "$1" == "" ]); then
	print_usage
fi

if ([ "$1" == "-d" ] || [ "$1" == "--delete" ] ); then
	delete_tag_files
	exit 0
fi

if ([ "$1" == "-t" ] || [ "$1" == "--tags" ] ); then
	delete_tag_files
	find $(pwd) -type f -name '*.zig' | while read zigfile; do generate_tag_files "$zigfile"; done
	printf "\n"
	printf "==================== DONE ======================\n"
	exit 0
fi




