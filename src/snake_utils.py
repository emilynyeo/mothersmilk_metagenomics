from os import path

# extract only the part of the sample name before the first "." or "_".
def read_sample_names(filename):
    with open(filename, 'r') as file:
        return [line.strip().split('.')[0].split('_')[0] for line in file]

# extract the sample name from a file without splitting it
def read_samples_full(filename):
    with open(filename, 'r') as file:
        return [line.strip() for line in file]
    
# functions to handle the resources passed to each rule:

def get_partition(default, config, rule_name):
    # First, check the config for a rule-specific partition
    config_param = config.get(f"{rule_name}_partition")
    if config_param is not None:
        return config_param
    # Then, check the config for a different default partition name
    # This looks for default_short_partition_name or default_long_partition_name
    # in case users need a different name for these short and long partitions
    config_diff_default = config.get(f"default_{default}_partition_name")
    if config_diff_default is not None:
        return config_diff_default
    
    # If there's nothing in the config, use what's in the snakefile
    return default


def get_mem(default, config, rule_name):
    config_param = config.get(f"{rule_name}_mem_mb")
    if config_param is not None:
        return int(config_param)
    return default


def get_runtime(default, config, rule_name):
    config_param = config.get(f"{rule_name}_runtime")
    if config_param is not None:
        return int(config_param)
    return default


def get_threads(default, config, rule_name):
    config_param = config.get(f"{rule_name}_threads")
    if config_param is not None:
        return int(config_param)
    return default


def get_slurm_extra(config, rule_name):
    config_param = config.get(f"{rule_name}_slurm_extra")
    if config_param is not None:
        return config_param
    
    config_diff_default = config.get(f"default_slurm_extra")
    if config_diff_default is not None:
        return config_diff_default
    
    return ""

