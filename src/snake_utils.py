from os import path

# extract only the part of the sample name before the first "." or "_".
def read_sample_names(filename):
    with open(filename, 'r') as file:
        return [line.strip().split('.')[0].split('_')[0] for line in file]

# extract the sample name from a file without splitting it
def read_samples_full(filename):
    with open(filename, 'r') as file:
        return [line.strip() for line in file]
