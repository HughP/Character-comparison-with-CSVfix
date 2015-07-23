#!/bin/bash
##########################
# Character comparison with CSVfix
##########################

#The goal here is to determin which characters have been removed through a given process.
#We first start with two files: the raw wiki file and the script processed file.

#UnicodeCCount has several flags. These flags will be used later in the processing. We are mainly interested in getting rid of characters which are part of the wikipedia formating, rather than characters which are part of the writer's experinece.

FILE=file-list.txt
FILE_BASE=basenames.txt
STATS_FILES

find * -iname '*nvwiki*.txt' > $FILE

for i in $(cat $FILE); do
	echo ${i%%.txt} > $FILE_BASE
done

for i in $(cat $FILE_BASE);do
	UnicodeCCount ${i}.txt > ${i}-character-stats.txt
done

find * -iname '*nvwiki*.txt' > $FILE


exit;0

This creates a file which needs tailed so that the top line is not used. We are not doing this in a single step because I want to be able to come back and look at the raw file, if needed.

cat ${funtional_units} | tail -n +6 | cut -d',' -f1 > functional-units.txt