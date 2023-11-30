import os
from types import SimpleNamespace
config = SimpleNamespace(**config)

# extract only the part of the sample name before the first "." or "_".
# THIS FUNCTION NEEDS A NEAT DEFINITION? 
def read_sample_names(filename):
    with open(filename, 'r') as file:
        return [line.strip().split('.')[0].split('_')[0] for line in file]

# Read sample names from "sample_names.txt" made using src/sample_names.py prior to snakemake
samples=read_sample_names(f"{config.sample_IDs}")