#########################################################################
# File Name: lazyrank.sh
# Author: Xianchao Wu
# mail: xianchaow@nvidia.com
# Created Time: Sat Jul 22 07:28:48 2023
#########################################################################
#!/bin/bash

if [ $# -lt 1 ]
then
	echo "Usage: $0 <log.fn>"
	exit 1
fi

logfn=$1

head -n 28 $logfn | tail -n 1 | python sep.py > $logfn.lazyrank.json
