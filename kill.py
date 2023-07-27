import sys
import os
with open('temp') as br:
    for aline in br.readlines():
        aline = aline.strip()
        if '7b-' in aline:
            continue

        if 'python' in aline or 'finetune_guanaco' in aline:
            aid = aline.split(' ')[0]
            acmd = 'kill {}'.format(aid)
            os.system(acmd)
