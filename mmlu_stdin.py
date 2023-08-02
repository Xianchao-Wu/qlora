import sys
import os

def acc(aline):
    cols = aline.split(' ')
    res = cols[-1][:-1]
    return float(res)

res = list()

model, ckpt = "", ""

for aline in sys.stdin:
    aline = aline.strip()
    if aline.startswith('mpath='):
        #print(aline)
        model = aline
    if 'mmlu_eval_accuracy' in aline or 'mmlu_test_accuracy' in aline:
        aline = aline.replace('\'', '\"')
        #print(aline)
        mmlu_acc = acc(aline)
        #print(mmlu_acc)
        flag = 'mmlu_eval_accuracy' if 'mmlu_eval_accuracy' in aline else 'mmlu_test_accuracy'
        three = (mmlu_acc, flag, model, ckpt)
        res.append(three)
    if 'checkpoint' in aline and 'workspace' in aline and 'Loading' not in aline:
        #print(aline)
        ckpt = aline

for three in res:
    athree = str(three)
    athree = athree[1:-1].replace(',', ' ').replace('\'', '')
    print(athree)
