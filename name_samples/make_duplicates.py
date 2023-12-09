import os
import pandas as pd
from os.path import join as pj
from os.path import split
from src.snake_utils import read_samples_full, read_sample_names, get_partition, get_mem, get_runtime, get_threads, get_slurm_extra
from types import SimpleNamespace

# Load sample names
sample_list = "/pl/active/ADOR/projects/mothersmilk/mothersmilk_metagenomics/sample_names_long.txt"
samples = read_samples_full("/pl/active/ADOR/projects/mothersmilk/mothersmilk_metagenomics/sample_names_long.txt")

# Identify duplicates
duplicate_samples = [sample for sample in set(samples) if samples.count(sample) > 1]

# Write duplicate samples to a text file
# output_file_path = "duplicate_samples.txt"  # Specify the file path
# with open(output_file_path, 'w') as file:
#    for sample in duplicate_samples:
#        file.write(sample + '\n')

# Read the content of duplicate_samples.txt
file_path = "duplicate_samples.txt"  # Specify the file path
with open(file_path, 'r') as file:
    lines = file.readlines()

# Count occurrences of each line
occurrences = {}
for line in lines:
    line = line.strip()  # Remove leading/trailing whitespaces and newline characters
    if line in occurrences:
        occurrences[line] += 1
    else:
        occurrences[line] = 1

# Count the number of duplicate lines
duplicate_count = sum(count - 1 for count in occurrences.values() if count > 1)
print(f"Number of duplicate lines in {file_path}: {duplicate_count}")

# Open the file and count the lines
count = 0
with open(file_path, 'r') as file:
    for line in file:
        count += 1

print(f"Total number of files in {file_path}: {count}")
print(f"Total number of files in {sample_list}: {count}")