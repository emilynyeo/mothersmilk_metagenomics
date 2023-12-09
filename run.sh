#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=15:00:00
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --job-name=test_runs
#SBATCH --ntasks=10
#SBATCH --mail-type=NONE
#SBATCH --mail-user=emye7956@colorado.edu

set -e pipefail

### TODO: modify these paths for each setup! 

# scripts
index_script=src/index.sh # This has the snakefile instructions

# directories
main_dir="/pl/active/ADOR/projects/mothersmilk/mothersmilk_metagenomics/"
out_dir="/pl/active/ADOR/projects/mothersmilk/mothersmilk_metagenomics/doc/"
config_dir="/pl/active/ADOR/projects/mothersmilk/mothersmilk_metagenomics/src/"

# config file
config_file=$config_dir'config.yml' # This file also needs unique path changes prior

# make log directory
test ! -d $out_dir"log/" && mkdir $out_dir"log/"

# move to project dir
cd $main_dir

# run indexing step
echo "Running QC step."
bash $index_script $main_dir $out_dir $config_file