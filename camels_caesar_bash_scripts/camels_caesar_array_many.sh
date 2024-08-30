#!/bin/bash
#SBATCH --job-name=camels_caesar_gen
#SBATCH --output=array_caesar_%A-%a.log
#SBATCH --mail-type=ALL
#SBATCH --mail-user=d.zimmerman@ufl.edu
#SBATCH --ntasks=8
#SBATCH --nodes=1
#SBATCH --mem=120gb
#SBATCH --account=narayanan
#SBATCH --qos=narayanan-b
#SBATCH --time=10:00:00
#SBATCH --array=90


#14,18,24,28,32-90:2%10

date;hostname;pwd;
cd /home/d.zimmerman
module purge
source .bashrc

conda activate /blue/narayanan/d.zimmerman/code_environments/caesar_camels_environment

module load git
module load gcc/12.2.0
module load openmpi/4.1.5
module load hdf5/1.14.1

cd /orange/narayanan/d.zimmerman/camels_caesar_catalogs_gen/caesar_scripts/

ref_file="/orange/narayanan/d.zimmerman/camels_caesar_catalogs_gen/caesar_scripts/caesar_sim_ref.txt"

sim_num=$1

sim_type=$(awk '{if(NR==4*n+1) print $0}' n=${sim_num} ${ref_file})
suite=$(awk '{if(NR==4*n+2) print $0}' n=${sim_num} ${ref_file})
id=$(awk '{if(NR==4*n+3) print $0}' n=${sim_num} ${ref_file})

echo "SIM ID:$sim_type"


python camels_all_caesar_gen.py ${sim_type} ${suite} ${id} ${SLURM_ARRAY_TASK_ID}

date

