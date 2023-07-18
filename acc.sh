#########################################################################
# File Name: acc.sh
# Author: Xianchao Wu
# mail: xianchaow@nvidia.com
# Created Time: Thu Jul 13 08:24:43 2023
#########################################################################
#!/bin/bash

if [ $# -lt 1 ]
then
	echo "$0 <in.log>"
	exit 1
fi

inlog=$1

grep "'mmlu_eval_accuracy':" $inlog | awk 'BEGIN{FS=", "}{for(i=1; i<=NF; i++){print $i}}' | grep "'mmlu_eval_accuracy':"
