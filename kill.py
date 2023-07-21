import sys
import os
with open('temp') as br:
    for aline in br.readlines():
        if 'python' in aline:
            aid = aline.split(' ')[0]
            acmd = 'kill {}'.format(aid)
            os.system(acmd)
