import numpy as np
import scipy as sp
import sys,os

sims_list = ['SIMBA','IllustrisTNG']
suite_list = ['1P','CV','EX','BE','LH']

p_list = ['n2','n1','1','2']


res_list = []

for suite in suite_list:
    for sim in sims_list:
        if(suite == '1P'):
            temp = [suite,sim,'1P_p1_0']
            print(temp)
            res_list.append(temp)
            for i in range(28):
                for j in p_list:
                    temp = [suite,sim,f'1P_p{i+1}_{j}']
                    print(temp)
                    res_list.append(temp)
        elif(suite == 'CV'):
            for i in range(27):
                temp = [suite,sim,f'CV_{i}']
                print(temp)
                res_list.append(temp)
        elif(suite =='EX'):
            for i in range(4):
                temp = [suite,sim,f'EX_{i}']
                print(temp)
                res_list.append(temp)
        elif(suite =='BE'):
            for i in range(27):
                temp = [suite,sim,f'BE_{i}']
                print(temp)
                res_list.append(temp)
        else:
            for i in range(1000):
                temp = [suite,sim,f'LH_{i}']
                print(temp)
                res_list.append(temp)
print(res_list[:100])

with open('caesar_sim_ref.txt', 'w') as output:
    for it in res_list:
        output.write(f'{it[1]}\n')
        output.write(f'{it[0]}\n')
        output.write(f'{it[2]}\n')
        output.write('\n')

