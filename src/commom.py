# log in to the cluster
ssh emye7956@login.rc.colorado.edu

# go to MM
cd /pl/active/ADOR/projects/mothersmilk/

# reactivate my github when i log on to the cluster or change nodes
ssh-add /home/emye7956/.ssh/id_rsa

# run snakemake manually from the main dir if you want to use the index script
main_dir="/pl/active/ADOR/projects/mothersmilk/mothersmilk_metagenomics/"
out_dir="/pl/active/ADOR/projects/mothersmilk/mothersmilk_metagenomics/doc/"
config_dir="/pl/active/ADOR/projects/mothersmilk/mothersmilk_metagenomics/src/"
bash $index_script $main_dir $out_dir $config_file 

# run snakemake using the cookiecutter profile
snakemake --profile /pl/active/ADOR/projects/mothersmilk/mothersmilk_metagenomics/.config/snakemake/slurm --configfile /pl/active/ADOR/projects/mothersmilk/mothersmilk_metagenomics/.config/snakemake/slurm/ems_config.yaml