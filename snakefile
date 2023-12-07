import os
import pandas as pd
from os.path import join as pj
from os.path import split
from src.snake_utils import read_samples_full, read_sample_names, get_partition, get_mem, get_runtime, get_threads, get_slurm_extra
from types import SimpleNamespace
#config = SimpleNamespace(**config)

# Read sample names from "sample_names.txt" made using src/sample_names.py prior to snakemake
samples=read_samples_full(f"{config['sample_IDs']}")

rule all:
    # test output:
    input:
        expand(f"{config['out_dir']}test/{{sample}}_1.txt", sample=samples),
        expand(f"{config['out_dir']}test/{{sample}}_2.txt", sample=samples),
    # fastqc1 output:
        expand(f"{config['fastqc1']}{{sample}}", sample=samples),
    # multiqc output:
        f"{config['fastqc1']}multiqc_report.html",
    # trim adapters:
        expand(f"{config['trim_adapters']}{{sample}}/{{sample}}.trimmed_1P", sample=samples),
        expand(f"{config['trim_adapters']}{{sample}}/{{sample}}.trimmed_2P", sample=samples),
        expand(f"{config['trim_adapters']}{{sample}}/{{sample}}.trimmed", sample=samples),
    
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
        mem_mb=2000, # MB
        partition="amilan",
        slurm_extra="--nodes=1 --qos=normal --time=20:00:00 --ntasks=1 --mail-type=ALL --mail-user=emye7956@colorado.edu"
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
rule multiqc1:
    input:
        #directory(f"{config['fastqc1']}")
        F1=expand(f"{config['fastqc1']}{{sample}}{{sample}}_1_fastqc.zip", sample=samples),
        F2=expand(f"{config['fastqc1']}{{sample}}{{sample}}_2_fastqc.zip", sample=samples)
    output:
        #directory(f"{config['fastqc1']}{{multiqc_data}}"),
        #f"{config['fastqc1']}{{multiqc_report}}.html",
        html=f"{config['fastqc1']}multiqc_report.html",
        #data=directory(f"{config['fastqc1']}multiqc_data")
    resources:
        mem_mb=2000, # MB
        partition="amilan",
        slurm_extra="--nodes=1 --qos=normal --time=20:00:00 --ntasks=1 --mail-type=ALL --mail-user=emye7956@colorado.edu"
    threads: 1
    params:
        fastqc1=config['fastqc1']
    shell:
        """
        cd {params.fastqc1}
        multiqc .
        # multiqc {params.fastqc1} -o {params.fastqc1}
        """

rule trim_and_adapters:
    input:
        FORWARD=expand(f"{config['data_dir']}{{sample}}_1.fq.gz", sample=samples),
        REVERSE=expand(f"{config['data_dir']}{{sample}}_2.fq.gz", sample=samples)
    output:
        #expand(f"{config['trim_adapters']}{{sample}}/{{sample}}.trimmed_1P", sample=samples),
        #expand(f"{config['trim_adapters']}{{sample}}/{{sample}}.trimmed_2P", sample=samples),
        #expand(f"{config['trim_adapters']}{{sample}}/{{sample}}.trimmed", sample=samples),
        #expand(f"{config.out_dir}trimmed_output/{{sample}}/{{sample}}.trimmed_2U", sample=samples),
        directory(f"{config['trim_adapters']}{{sample}}")
    conda:
        "trimmomatic_env"
    resources:
        mem_mb=2000, # MB
        partition="amilan",
        slurm_extra="--nodes=1 --qos=normal --time=20:00:00 --ntasks=1 --mail-type=ALL --mail-user=emye7956@colorado.edu"
    threads: 1
    params:
        trimout=config['trim_adapters'],
        flops=config['flops'],
        min=config['min_readlen'],
        lead=config['leading'],
        trail=config['trailing'],
        swindow=config['swindow'],
        adapters=config['adapters'],
    shell:
        """
        touch {params.flops}
        mkdir -p {params.trimput}{wildcards.sample}
        trimmomatic PE -threads 1 \
            -trimlog {params.trimput}{wildcards.sample}/{wildcards.sample}.trimlog \
            -summary {params.trimput}{wildcards.sample}/{wildcards.sample}.trim.log \
            -validatePairs {input.FORWARD} {input.REVERSE} \
            -baseout {params.trimout}{wildcards.sample}/{wildcards.sample}.trimmed \
            ILLUMINACLIP:{params.adapters} SLIDINGWINDOW:{params.swindow} LEADING:{params.lead} TRAILING:{params.trail} MINLEN:{params.min} \
            || echo {wildcards.sample} >> {params.flops}
        """ 

# rule fastqc2:
# rule hostile:
# rule fastqc3:
# rule download_kraken_db:
# rule downlad_humann_db:
# rule run_humann:
# rule run_kracken:
# rule run_bracken:
# rule merge_outputs:    