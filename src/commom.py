# log in to the cluster
ssh emye7956@login.rc.colorado.edu
# go to MM
cd /pl/active/ADOR/projects/mothersmilk/
# reactivate my github when i log on to the cluster or change nodes
ssh-add /home/emye7956/.ssh/id_rsa

# run snakemake manually from the main dir
main_dir="/pl/active/ADOR/projects/mothersmilk/mm_pipeline/"
out_dir="/pl/active/ADOR/projects/mothersmilk/mm_pipeline/doc/"
config_dir="/pl/active/ADOR/projects/mothersmilk/mm_pipeline/src/"
bash $index_script $main_dir $out_dir $config_file 
