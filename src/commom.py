# log in to the cluster
ssh emye7956@login.rc.colorado.edu

# go to MM
cd /pl/active/ADOR/projects/mothersmilk/

# reactivate my github when i log on to the cluster or change nodes
ssh-add /home/emye7956/.ssh/id_rsa

# interactive session:
salloc --nodes=1 --ntasks=10 --cpus-per-task=1 --mem=3000 --time=03:00:00
sinteractive --partition=amilan --nodes=1 --time=02:10:00 --ntasks=1 --mem=3000

# want to check up on a job:
squeue --account=emye7956

# run snakemake manually from the main dir if you want to use the index script
main_dir="/pl/active/ADOR/projects/mothersmilk/mothersmilk_metagenomics/"
out_dir="/pl/active/ADOR/projects/mothersmilk/mothersmilk_metagenomics/doc/"
config_dir="/pl/active/ADOR/projects/mothersmilk/mothersmilk_metagenomics/src/"
bash $index_script $main_dir $out_dir $config_file 

# running snakefile demo on acompile:
snakemake -s snakefile_test \
    --profile /pl/active/ADOR/projects/mothersmilk/mothersmilk_metagenomics/.config/snakemake/slurm \
    --configfile src/ems_config.yaml \
    --use-conda \
    -c 1 \
    -j 1 \
    --dryrun \
    --quiet \

# if you only want to rul a particular rule:
snakemake -s snakefile_test \
    --profile /pl/active/ADOR/projects/mothersmilk/mothersmilk_metagenomics/.config/snakemake/slurm \
    --configfile src/ems_config.yaml \
    --use-conda \
    --allowed-rules test \
    -c 1 \
    -j 1 \
    --dryrun \
    --quiet 

# run snakemake using the cookiecutter profile
snakemake --profile /pl/active/ADOR/projects/mothersmilk/mothersmilk_metagenomics/.config/snakemake/slurm \
    --configfile src/ems_config.yaml \
    --use-conda \
    --dryrun \
    --quiet \
    --printshellcmds 

    --rulegraph
    --dryrun --printshellcmds
    --dag | dot -Tpng > dag.png
    snakemake --forceall --dag | dot -Tpdf > dag.pdf