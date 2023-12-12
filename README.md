# mothersmilk_metagenomics
Metagenomic processing of Mothersmilk cohort samples

## 1. Logging onto the cluster
You will need duo mobile set up and have internet connection on your. If you are using the CU Boulder Fiji cluster, you will need to be on the VPN if you are not on campus wifi. If using Alping and the Peta Library, use `ssh emye7956@login.rc.colorado.edu` (replace my user ID with yours). Then get to the project directory using `cd /pl/active/ADOR/projects/mothersmilk/`. Everything you need to know about the CU Boulder clusters can be found [here](https://curc.readthedocs.io).

#### IMPORTANT
Once logged on, you'll be on a login node of the cluster. This is not a powerful node and is not the place to download or run things. It's ok for checking up on prior submitted jobs, submitting jobs (sometimes) and making small script edits. If you want to play with the more powerful nodes, there are a few options [(see here)](https://curc.readthedocs.io/en/latest/running-jobs/job-resources.html) that will take too long to get into. But I usually use `acompile --time=02:00:00` ... if I want a node for 2 hours. By default this puts you on an Amilan node with 1 core and 3GB of memory. So ask for more if you plan to exceed that when testing things. All metagenomic tools will require more resources. These you specify when submitting jobs [(see here)](https://curc.readthedocs.io/en/latest/running-jobs/batch-jobs.html). Be careful with this, because you can break a node if you run something without enought resources. When in doubt, email your questions in detail to `rc-help@colorado.edu` or lookup their weekly office hours. They are always SO awesome and helpful. 

## 2. Connecting to github
This is seriously useful and something I figured out way too late, at it allows you to keep a history of all your changes to the code over time. Setting this up will differ slightyly depending on the cluster you are using. But for Alpine/Peta Library, do the following:

  1. Navigate to Github in your browser
  2. Select your icon in the top right corner, and then select 'Settings'
  3. On the left side, scroll down to 'Developer Settings'
  4. Select 'Personal Access Tokens' and then 'Tokens (Classic)'. Select all the boxes.
  5. From there, you can generate a new token. Once the token is generated, you'll want to use the 'HTTPS' option when cloning a repo.
  6. Whenever you're prompted for a password, you'll want to input the personal access token.
  7. Then once you're changes are commited and you'd like to push, use:

```
git remote -v     
git remote set-url origin https://insert_token_here@github.com/github_name/repo_name.git
# example below    
# git remote set-url origin https://insert_token_here@github.com/emilynyeo/mothersmilk_metagenomics.git     
git push 
```
### Cloning repo
Pretty simple. Go to where you want the github directory to appear and type 'git clone <https_link>`.

## 3. Setting up environments 
Most of metagenomics opperate in seperate environments so that they play nicely together.  If you are not sure which environments you have, type `conda env list` to get an idea. You can export an environment into a yaml file, so that someone can then reproduce that exact same environment on their own computer. All the environments for the mothersmilk metagenomic pipeline have been saved and are ready rumble. 

So after cloning this repo, go to the main directory of the repo and type `conda env create -f env/snakemake.yaml` followed by `conda activate snakemake`. Your should see "(snakemake)" on the left of your cursor and username.

## 4. Snakemake
Our hero... sometimes. [Here](https://sterrettjd.github.io/Effective-Snakemake-HPC/) is a great intro made by John Sterrett. His github is also super helpful. I also reccomend taking a look at the [snakemake manual](https://snakemake.readthedocs.io/en/stable/). 
But to get going with this, let's set up a snakemake profile. The steps to follow are [here](https://sterrettjd.github.io/Effective-Snakemake-HPC/quarto/Snakemake-Essentials.html).

### Installating cookiecutter
In your Snakemake Conda environment:

```
conda activate env/snakemake.yaml
pip install pipx
pipx install cookiecutter
pipx ensurepath
```

### Snakemake SLURM profile setup

In your Snakemake Conda environment:

#### create config directory that snakemake searches for profiles (or use something else)
```
MAIN="/pl/active/ADOR/projects/mothersmilk/mothersmilk_metagenomics/" 
profile_dir="${MAIN}/.config/snakemake"
mkdir -p "$profile_dir"
```

#### use cookiecutter to create the profile in the config directory
```
template="gh:Snakemake-Profiles/slurm"
cookiecutter --output-dir "$profile_dir" "$template"
```

## Running Snakemake.
Before staring, check to see if path and parameters need to be changed in `run.sh` and `src/index.sh` and `src/ems_config.yaml`. I actually recommend making your own config and referencing it in the index and run files. 

Do you want to do a demo run or a full blown run? ... Probably demo. This can be done in 2 ways, but I recommend the sbatch way (way 2 below), just because it better mimics what would actually happen and you can ask for more resources. 

  **way1:** 

  **way2:**

## About the Rules being Run.



