import yt
import caesar
import sys,os

sim = str(sys.argv[1])
suite_name = str(sys.argv[2])
run_id = str(sys.argv[3])
snap_num = int(sys.argv[4])

base_path = '/orange/narayanan/d.zimmerman/camels_caesar_catalogs_gen/'

sim_id = f'{sim}/{suite_name}/{run_id}'
sim_dir = f'{base_path}/Sims/{sim_id}/'
pro = 1

print('sim: ',sim_id)
print('snap: ',snap_num)

ssp_table_file = f'{base_path}/FSPS_Chab_EL.hdf5'

if(snap_num < 10):
    snap_str = f'00{snap_num}'
elif(snap_num < 100):
    snap_str = f'0{snap_num}'
else:
    snap_str = f'{snap_num}'
    

caesar_save_loc = f'{base_path}/Caesar/{sim_id}/caesar_newsnaps_{snap_str}.hdf5'
fof_save_loc = f'{base_path}/Caesar/{sim_id}/fof6d_newsnaps_{snap_str}'

ds = yt.load(f'{sim_dir}/snapshot_{snap_str}.hdf5')
print()
print("loaded")
print()
caes_obj = caesar.CAESAR(ds)
print()
print("object setup")
print()
#caes_obj.member_search(haloid = 'fof',blackholes=True,skipran=False,fof6d = True,nproc = pro)
caes_obj.member_search(haloid='fof', fof6d_file=fof_save_loc, fsps_bands='uvoir',
        ssp_model='FSPS', ssp_table_file=ssp_table_file,
        ext_law='composite', nproc=pro)
print()
print("member search")
print()
caes_obj.save(caesar_save_loc)

print()
print("saved")
print()


