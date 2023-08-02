#########################################################################
# File Name: collect_mmlu_test.sh
# Author: Xianchao Wu
# mail: xianchaow@nvidia.com
# Created Time: Sat Jul 29 10:10:40 2023
#########################################################################
#!/bin/bash

for alog in `ls scripts/*.3 scripts/*.4`
do
	echo $alog
	python mmlu.py $alog
done
