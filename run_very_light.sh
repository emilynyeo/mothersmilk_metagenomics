#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=1:00:00
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --job-name=test_runs
#SBATCH --ntasks=1
#SBATCH --mail-type=NONE
#SBATCH --mail-user=emye7956@colorado.edu

set -e pipefail

### TODO: modify these paths for each setup! 

# scripts
index_script=src/index.sh # This has the snakefile instructions

# directories
main_dir="/pl/active/ADOR/projects/mothersmilk/mm_pipeline/"
out_dir="/pl/active/ADOR/projects/mothersmilk/mm_pipeline/doc/"
config_dir="/pl/active/ADOR/projects/mothersmilk/mm_pipeline/src/"

# config file
config_file=$config_dir'config.yaml' # This file also needs unique path changes prior

# make log directory
test ! -d $out_dir"log/" && mkdir $out_dir"log/"

# move to project dir
cd $main_dir

# run indexing step
echo "Running QC step."
bash $index_script $main_dir $out_dir $config_file
