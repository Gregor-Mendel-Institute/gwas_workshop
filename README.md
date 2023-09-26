[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/picla/GWAS_workshop_CK/master)

# GWAS_workshop
How to GWAS

## Create an conda-environment to be able to...


To make sure all required packages are installed, it's practical to create the conda environment locally
and activate this environment (do this in each new bash window)

```bash
conda env create -f environment.yml
conda activate limix
```

If this takes too long and/or doesn't work, then try:
```bash
./create_env.sh
```

## Start
The jupyter notebooks can be used in an executable environment by clicking the Binder badge above.

To use the notebooks locally, download the notebook(s) of choice and from that directory run

```bash
jupyter notebook
```


## Install conda

Check if conda is installed:

```bash
conda --version
```

When conda is not installed locally, we advise installing [miniconda](https://docs.conda.io/projects/miniconda/en/latest/) or [anaconda](https://www.anaconda.com/distribution/) 


Click [here](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#sharing-an-environment) for more information on conda environments.



