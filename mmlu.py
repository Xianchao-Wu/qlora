import sys
import os

if len(sys.argv) < 2:
    print("Usage: {} <log.fn>".format(sys.argv[0]))
    sys.exit()

logfn=sys.argv[1]

def acc(aline):
    cols = aline.split(' ')
    res = cols[-2]
    if 'epoch' in res:
        res = cols[-3]
    else:
        res = cols[-1]

    res = res[:-1]
    return res #cols[-1][:-1]

res = list()

model, ckpt = "", ""

with open(logfn) as br:
    for aline in br.readlines():
        aline = aline.strip()
        if aline.startswith('mpath='):
            #print(aline)
            model = aline
        if 'mmlu_eval_accuracy' in aline or 'mmlu_test_accuracy' in aline:
            aline = aline.replace('\'', '\"')
            print(aline)
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
    athree = athree[2:-1].replace('\'', '').replace(',', ' ')
    print(athree)
