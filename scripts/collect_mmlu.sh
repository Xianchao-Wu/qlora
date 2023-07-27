#########################################################################
# File Name: collect_mmlu.sh
# Author: Xianchao Wu
# mail: xianchaow@nvidia.com
# Created Time: Thu Jul 27 07:20:56 2023
#########################################################################
#!/bin/bash

for alog in `ls *4bit.sh.log`
do
	python ../mmlu.py $alog
done

for alog in `ls *4bit_mmlutest.sh.log`
do
	python ../mmlu.py $alog
done
