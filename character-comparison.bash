#!/bin/bash
################################################################################
# Character comparison with CSVfix
################################################################################

#The goal here is to determine which characters have been removed through a 
#given process. We first start with two files: the raw wiki file and the script
#processed file.

#UnicodeCCount has several flags. These flags will be used later in the 
#processing. We are mainly interested in getting rid of characters which are part
#of the wikipedia formatting, rather than characters which are part of the 
#writer\'s experience.

for i in $(find * -iname '*nvwiki*.txt'); do
	UnicodeCCount "${i}" > "${i%%.txt}"-character-stats.tab
done

ARRAY=$(find * -iname '*character-stats*.tab')

#Need to remove the first tab in the file. Need to tell csvfix to use read_dsv Need to remove the head line of the tab documents too.
csvfix join -f 2:2 ${ARRAY[0]} ${ARRAY[1]}
exit;0

This creates a file which needs tailed so that the top line is not used. We are not doing this in a single step because I want to be able to come back and look at the raw file, if needed.

cat ${funtional_units} | tail -n +6 | cut -d',' -f1 > functional-units.txt