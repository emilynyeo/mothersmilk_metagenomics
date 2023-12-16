#!/bin/bash

# these positional arguments get called in in run.sh 
main_dir=$1 # This is where the snakefile and runsh file is
out_dir=$2
config=$3 

echo $main_dir
echo $out_dir
echo $config

## These directories should be correct.
## If you have changed where scripts exist, change these paths
smk_dir=$main_dir
log=$out_dir'log/ind_log.txt'

echo 'Going to project directory...'
cd $main_dir
#echo 'Activating snakemake conda env ...'
module purge
module load anaconda
conda activate snakemake

# runnning MM pipeline
echo 'running MM pipeline' > $log
start_slice=$(date +%s.%3N)
snakemake -s Snakefile_resources_nov24 \
    --profile /pl/active/ADOR/projects/mothersmilk/mothersmilk_metagenomics/.config/snakemake/slurm \
    --configfile src/ems_config.yaml \
    --use-conda \
    -c 2 \
    -j 1 \
    --dryrun \
    --quiet \
    --printshellcmds
end_slice=$(date +%s.%3N)
slice_time=$(echo "scale=3; $end_slice - $start_slice" | bc)
echo "QC: $slice_time seconds" >> $log
#--configfile=$ems_config \