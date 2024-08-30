#!/bin/bash 

#V1 bash simulation loader/requester for CAMELS data
#this assumes you have made a Globus guest collection on hipergator to run things on
#SIMBA or IllustrisTNG 0 or 1

#camels globus ID

#Notes of interest:
CAMELS_GLOBUS="58bdcd24-6590-11ec-9b60-f9dfb1abb183"
HPG_COLLECT_GLOBUS="17c5e656-ac04-402f-b904-973a587b9ba0"
CAMELS_SIMS_DIR="/Sims/"
LOCAL_SIMS_DIR="/Sims/"

snum_min=$1
snum_max=$2

ref_file="/orange/narayanan/d.zimmerman/camels_caesar_catalogs_gen/caesar_scripts/caesar_sim_ref.txt"

module load globus

for ((cur_snum=${snum_min}; cur_snum<=${snum_max}; cur_snum++))
do
	sim_type=$(awk '{if(NR==4*n+1) print $0}' n=${cur_snum} ${ref_file})
	suite=$(awk '{if(NR==4*n+2) print $0}' n=${cur_snum} ${ref_file})
	id=$(awk '{if(NR==4*n+3) print $0}' n=${cur_snum} ${ref_file})
	echo "sim physics:$sim_type"
	echo "sim suite:$suite"
	echo "sim id:$id"
		
	in_sim_dir="${CAMELS_SIMS_DIR}${sim_type}/${suite}/${id}/"
	out_sim_dir=$in_sim_dir
	
	
	globus transfer --recursive --dry-run ${CAMELS_GLOBUS}:${in_sim_dir} ${HPG_COLLECT_GLOBUS}:${out_sim_dir}
	echo -e "\n"
	echo -e "running transfer\n"	
	globus transfer --recursive ${CAMELS_GLOBUS}:${in_sim_dir} ${HPG_COLLECT_GLOBUS}:${out_sim_dir}
	echo -e "\n"
	mkdir "/orange/narayanan/d.zimmerman/camels_caesar_catalogs_gen/Caesar/${sim_type}"
	mkdir "/orange/narayanan/d.zimmerman/camels_caesar_catalogs_gen/Caesar/${sim_type}/${suite}/"
	mkdir "/orange/narayanan/d.zimmerman/camels_caesar_catalogs_gen/Caesar/${sim_type}/${suite}/${id}/"


	#echo -e "Please confirm the transfer is correct (y/n):"
	
	#read confirm
	
	#if [ "$confirm" = "y" ]
	#then
	#	echo -e "confirmed"
#		globus transfer --recursive ${CAMELS_GLOBUS}:${in_sim_dir} ${HPG_COLLECT_GLOBUS}:${out_sim_dir}
#		echo -e "\n"
#                mkdir "/orange/narayanan/d.zimmerman/camels_caesar_catalogs_gen/Caesar/${sim_type}"
#		mkdir "/orange/narayanan/d.zimmerman/camels_caesar_catalogs_gen/Caesar/${sim_type}/${suite}/"
#		mkdir "/orange/narayanan/d.zimmerman/camels_caesar_catalogs_gen/Caesar/${sim_type}/${suite}/${id}/"

	#else
#		echo -e "transfer cancelled"
	#fi
done	
