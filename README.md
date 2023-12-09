# mothersmilk_metagenomics
Metagenomic processing of Mothersmilk cohort samples

## Logging onto the cluster
You will need duo mobile set up and have internet connection on your. If you are using the CU Boulder Fiji cluster, you will need to be on the VPN if you are not on campus wifi. If using Alping and the Peta Library, use `ssh emye7956@login.rc.colorado.edu` (replace my user ID with yours). Then get to the project directory using `cd cd /pl/active/ADOR/projects/mothersmilk/`.  

## Connecting to github

## Cloning repo

## Setting up environments 

## Snakemake

## Installating cookiecutter
In your Snakemake Conda environment:

"""
coonda activate env/snakemake.yaml
pip install pipx
pipx install cookiecutter
pipx ensurepath
"""

## Snakemake SLURM profile setup
In your Snakemake Conda environment:

# create config directory that snakemake searches for profiles (or use something else)
MAIN="/pl/active/ADOR/projects/mothersmilk/mm_pipeline/" 
profile_dir="${MAIN}/.config/snakemake"
mkdir -p "$profile_dir"

# use cookiecutter to create the profile in the config directory
template="gh:Snakemake-Profiles/slurm"
cookiecutter --output-dir "$profile_dir" "$template"
