import os
import pandas as pd
from os.path import join as pj
from os.path import split
from src.snake_utils import read_samples_full, read_sample_names, get_partition, get_mem, get_runtime, get_threads, get_host_mapping_samples, get_slurm_extra
from types import SimpleNamespace
#config = SimpleNamespace(**config)

# Read sample names from "sample_names.txt" made using src/sample_names.py prior to snakemake
samples=read_sample_names(f"{config.sample_IDs})

rule all:
    input:
        expand(f"{config.out_dir}test/{{sample}}_1.txt", sample=samples),
        expand(f"{config.out_dir}test/{{sample}}_2.txt", sample=samples)

rule test:
    input:
        F=f"{config.data_dir}{{sample}}_1.fq.gz",
        R=f"{config.data_dir}{{sample}}_2.fq.gz"
    output:
        test1.txt=f"{config.out_dir}test/{{sample}}_1.txt",
        test2.txt=f"{config.out_dir}test/{{sample}}_2.txt",
    shell:
        """
        mkdir -p {config.out_dir}test/
        ls -l {input.F} | awk '{print $9}' > {config.out_dir}test/{wildcards.sample}_1.txt
        ls -l {input.R} | awk '{print $9}' > {config.out_dir}test/{wildcards.sample}_2.txt
        """