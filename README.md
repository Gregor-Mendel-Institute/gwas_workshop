[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/picla/GWAS_workshop_CK/master)

# GWAS_workshop
How to GWAS



## Before the start..

### Install conda

Check if conda is installed:

```bash
conda --version
```

When conda is not installed locally, we advise installing [miniconda](https://docs.conda.io/projects/miniconda/en/latest/) or [anaconda](https://www.anaconda.com/distribution/) 

Click [here](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#sharing-an-environment) for more information on conda environments.


### Create a conda environment, aka "Magic Box," to keep projects separate


To make sure all required packages are installed, it's practical to create the conda environment locally:
```bash
conda env create -f environment.yml
```
and activate this environment in a new bash window:

```bash
conda activate limix
```

If creating takes too long and/or doesn't work, try step-by-step script:
```bash
./create_env.sh
```



## Start

To use the notebooks locally, download the notebook(s) of choice and from that directory run:

```bash
jupyter notebook
```

### Be sure, that both R and python kernels are properly installed

To check this you need to click "New" at the left top side of the page and be sure that you can create two types of netebooks: 
  - python
  - R

Create new notebooks of each type, in the opened window write `x = 0` and click "Run".

If R kernel doesn't work, follow the [instruction](https://github.com/IRkernel/IRkernel).


