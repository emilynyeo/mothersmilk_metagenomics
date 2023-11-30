import os
import sys

sys.path.insert(0, '../')  # noqa

# Path to origin raw data
data_dir = '/pl/active/ADOR/projects/mothersmilk/chla_data_transfer/fastq/fastq/'
out_dir = '/pl/active/ADOR/projects/mothersmilk/mm_pipeline/'

# List all files in the data_dir
files = os.listdir(data_dir)

# Define endings to exclude
excluded_endings = ["_1.fq.gz", "_2.fq.gz"]

# Extract sample names from the file names excluding specific endings
sample_names = [
    os.path.splitext(file)[0] for file in files
    if file.endswith('.fastq') or file.endswith('.fq.gz')
]

# Exclude specific endings from sample names
sample_names = [
    sample_name for sample_name in sample_names
    if not any(sample_name.endswith(ending) for ending in excluded_endings)
]

# Create a sample_names.txt file
sample_names_file_path = os.path.join(out_dir, 'sample_names_long.txt')
with open(sample_names_file_path, 'w') as sample_file:
    for sample_name in sample_names:
        sample_file.write(sample_name + '\n')
