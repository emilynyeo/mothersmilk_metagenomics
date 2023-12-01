# mothersmilk_metagenomics
Metagenomic processing of Mothersmilk cohort samples

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
