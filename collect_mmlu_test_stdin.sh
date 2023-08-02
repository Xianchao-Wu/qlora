#########################################################################
# File Name: collect_mmlu_test.sh
# Author: Xianchao Wu
# mail: xianchaow@nvidia.com
# Created Time: Sat Jul 29 10:10:40 2023
#########################################################################
#!/bin/bash

for akey in 7bhf 7bchathf 13bhf 13bchathf 70bhf 70bchathf
do
	echo '----'
	echo $akey
	cat scripts/*$akey*mmlutest*log* | python mmlu_stdin.py | sort -r
	echo '----'
done

exit 0

for alog in `ls scripts/*.3 scripts/*.4`
do
	echo $alog
	python mmlu.py $alog
done
