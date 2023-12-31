import os
import pandas as pd
from os.path import join as pj
from os.path import split
from src.snake_utils import read_samples_full, read_sample_names, get_partition, get_mem, get_runtime, get_threads, get_slurm_extra
from types import SimpleNamespace
#config = SimpleNamespace(**config)


# Read sample names from "sample_names.txt" made using src/sample_names.py prior to snakemake
samples=read_samples_full(f"{config['sample_IDs']}")
# Identify duplicates
duplicate_samples = [sample for sample in set(samples) if samples.count(sample) > 1]

rule all:
    # test output:
    input:
        expand(f"{config['out_dir']}test/{{sample}}_1.txt", sample=samples),
        expand(f"{config['out_dir']}test/{{sample}}_2.txt", sample=samples),
    # fastqc1 output:
        expand(f"{config['fastqc1']}{{sample}}_1_fastqc.zip", sample=samples),
        expand(f"{config['fastqc1']}{{sample}}_2_fastqc.zip", sample=samples)

rule test:
    input:
        F=f"{config['data_dir']}{{sample}}_1.fq.gz",
        R=f"{config['data_dir']}{{sample}}_2.fq.gz"
    output:
        f"{config['out_dir']}test/{{sample}}_1.txt",
        f"{config['out_dir']}test/{{sample}}_2.txt"
    params:
        out=config['out_dir']
    shell:
        """
        mkdir -p {params.out}test/
        basename {input.F} > {params.out}test/'{wildcards.sample}'_1.txt
        basename {input.R} > {params.out}test/'{wildcards.sample}'_2.txt
        """

rule fastqc1:
    input:
        FORWARD=expand(f"{config['data_dir']}{{sample}}_1.fq.gz", sample=samples),
        REVERSE=expand(f"{config['data_dir']}{{sample}}_2.fq.gz", sample=samples)
    output:
        directory(f"{config['fastqc1']}{{sample}}"),
        f"{config['fastqc1']}{{sample}}_1_fastqc.zip",
        f"{config['fastqc1']}{{sample}}_2_fastqc.zip"
    conda:
        "qc_env_with_fastqc_and_multiqc"
    resources:
        mem_mb=200, # MB
        partition="amilan",
        slurm_extra="--nodes=1 --qos=normal --time=10:00:00 --ntasks=1 --mail-type=ALL --mail-user=emye7956@colorado.edu"
    threads: 1
    params:
        fastqc1=config['fastqc1']
    shell:
        """
        mkdir -p {params.fastqc1}
        touch {params.fastqc1}failures.txt
        mkdir -p {output}
        fastqc --threads 1 {input.FORWARD} {input.REVERSE} -o {output} \
            || echo {wildcards.sample} >> {params.fastqc1}failures.txt
        """