#!/bin/bash
#SBATCH -t 1:00:00
#SBATCH -n 24
#SBATCH -p short

#Load modules
module load eb
module load Miniconda2

# loading virtualenv
source activate qiime1

# setting temporary directory
export TMPDIR=~/qiime1_tmp

# picking otus
echo "picking otus"
time pick_de_novo_otus.py -i ~/2018_02_smb/slout_2018_x/seqs.fna -o ~/2018_02_smb/otus_2018_denovo

#deactivating environment
source deactivate 