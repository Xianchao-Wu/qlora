#########################################################################
# File Name: accall.sh
# Author: Xianchao Wu
# mail: xianchaow@nvidia.com
# Created Time: Fri Jul 14 00:53:37 2023
#########################################################################
#!/bin/bash

for afile in `ls *.log`
do
	echo $afile
	./acc.sh $afile
done
