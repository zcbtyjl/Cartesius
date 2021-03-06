#!/bin/bash
#SBATCH -t 12:00:00
#SBATCH -n 24
#SBATCH -p normal

#Load modules
module load eb
module load Miniconda2

# loading virtualenv
source activate qiime1

# setting temporary directory
export TMPDIR=~/qiime_tmp

# splitting libraries 
echo "splitting libraries BOOYEAH"
time split_libraries_fastq.py --barcode_type 12 -i ~/2018_02_smb/fastqjoined_ends/fastqjoin.join.fastq -m ~/2018_02_smb/map_incomplete.tsv -b ~/2018_02_smb/fastqjoined_ends/fastqjoin.join_barcodes.fastq -o ~/2018_02_smb/slout_2018/ -q 3 --rev_comp_barcode --rev_comp_mapping_barcodes

# picking otus
echo "picking otus"
time pick_closed_reference_otus.py -i ~/2018_02_smb/slout_2018/seqs.fna -o ~/2018_02_smb/otus_2018 -a 
-O 24

# diversity analyses
echo "diversity analyses"
time core_diversity_analyses.py --recover_from_failure \
-o cdout_2018 \
-i ~/2018_02_smb/otus_2018/otu_table.biom \
-m ~/2018_02_smb/map_incomplete.tsv \
-t ~/2018_02_smb/otus_2018/97_otus.tree \
-e 1000

# counting sequences 
echo "Counting sequences"
time count_seqs.py -i ~/2018_02_smb/slout_2018/seqs.fna

#deactivating environment
source deactivate 