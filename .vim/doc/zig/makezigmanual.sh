#!/bin/bash
#

ZIGMANUAL=zigmanual.txt
ERROR_FNF="Error - File "$ZIGMANUAL" not found.\n"

[ -f "$ZIGMANUAL" ] || ( printf ERROR_FNF && exit 0 )

vim --cmd "helptags ./ | q"

# vim multilang bug or something
rm tags-hx
