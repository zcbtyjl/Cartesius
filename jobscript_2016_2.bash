#!/bin/bash
#SBATCH -t 10:00:00
#SBATCH -n 24
#SBATCH -p normal

#Load modules
module load eb
module load Miniconda2

# loading virtualenv
source activate qiime1

# setting temporary directory
export TMPDIR=~/qiime_tmp

# picking otus
echo "picking otus"
time pick_closed_reference_otus.py -i ~/2016_02_smb/slout_2016/seqs.fna -o ~/2016_02_smb/otus_2016

# diversity analyses
echo "diversity analyses"
time core_diversity_analyses.py --recover_from_failure -o cdout -i ~/2016_02_smb/otus_2016/otu_table.biom -m ~/2016_02_smb/map.tsv -t ~/2016_02_smb/otus_2016/97_otus.tree -e 1898

# counting sequences 
echo "Counting sequences"
time count_seqs.py -i ~/2016_02_smb/slout_2016/seqs.fna

#deactivating environment
source deactivate 