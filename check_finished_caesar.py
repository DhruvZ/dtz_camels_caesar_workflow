import sys,os
import numpy as np
import scipy as sp
from pathlib import Path

base_path = '/orange/narayanan/d.zimmerman/camels_caesar_catalogs_gen/'

sim_info = open(f"{base_path}/caesar_scripts/caesar_sim_ref.txt").read().split()

lim_low = int(sys.argv[1])
lim_high = int(sys.argv[2])

snaps = ['014','018','024','028','032','034','036','038','040','042','044','046','048','050','052','054','056','058','060','062','064','066','068','070','072','074','076','078','080','082','084','086','088','090']
print(sim_info[:10])
for i in range(lim_low,lim_high):
    x1 = sim_info[3*i]
    x2 = sim_info[3*i+1]
    x3 = sim_info[3*i+2]
    #print(x1)
    #print(x2)
    #print(x3)
    path = f'{base_path}/Caesar/{x1}/{x2}/{x3}'
    print(i)
    for snap in snaps:
        my_file = Path(f"{path}/fof6d_newsnaps_{snap}")
        if not my_file.is_file():
            print(f"{path}/fof6d_newsnaps_{snap}")
            print()
