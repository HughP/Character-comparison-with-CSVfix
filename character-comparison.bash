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

CORPORA=$(find * -iname '*nvwiki*.txt')

for i in $CORPORA; do
	UnicodeCCount "${i}" > "${i%%.txt}"-character-stats.tab
done

STATS=$(find * -iname '*.tab')

#Need to remove the first tab in the file. Need to tell csvfix to use read_dsv Need to remove the head line of the tab documents too.

for i in $STATS; do 
	tail -n +2 ${i} | csvfix read_dsv -s '\t' -f 2,3,4 > ${i%%.tab}.csv 
done


ARRAY=$(find * -iname '*nvwiki*character-stats*.csv')

#Join on unicode ID column which is normally column 2 of the UnicodeCCOunt output, but since we got rid of that before, now it is column 1. Then find the differnece between the two files (before and after use of the cleanup script) with eval. Then sort the data so that the rows on the top are the ones with diffences between the two files. Then narrow the output to those fields which have a mathmatical change which does not equal zero.
csvfix join -oj -f 1:1 ${ARRAY[0]} ${ARRAY[1]} | csvfix eval -e '($3 - $5)' | csvfix sort -f 6:DN | csvfix remove -f 6 -e '0'
exit;0

This creates a file which needs tailed so that the top line is not used. We are not doing this in a single step because I want to be able to come back and look at the raw file, if needed.

cat ${funtional_units} | tail -n +6 | cut -d',' -f1 > functional-units.txt