[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/picla/GWAS_workshop_CK/master)

# GWAS workshop
How to GWAS

There are two ways to work in the workshop: 
	-  run Jupyter Notebook locally (highly recommended) or 
	-  use an executable environment by clicking the Binder badge above.

For the first option , follow the instruction below:

## Before the start..

### Install conda

Check if conda is installed:

```bash
conda --version
```

When conda is not installed locally, we advise installing [miniconda](https://docs.conda.io/projects/miniconda/en/latest/) or [anaconda](https://www.anaconda.com/distribution/) 

Click [here](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#sharing-an-environment) for more information on conda environments.


### Create a conda environment, aka "Magic Box," to keep projects separate

Each environment can have its own set of packages and dependencies, which means that different projects can have different versions of libraries (and even Python itself) without interference.
You can set up the environment for gwas-workshop by entering this in the command line:
```bash
conda env create -f environment.yml
```

and then activate the environment in a new bash window::
```bash
conda activate gwas
```

If creating takes too long and/or doesn't work, try step-by-step script:
```bash
chmod +x create_env.sh
./create_env.sh
```


## Start

To use the notebooks locally, download the notebook(s) of choice and from that directory run:

```bash
jupyter notebook
```

### Be sure, that both R and python kernels are properly installed

To check this you need to click "New" at the left top side of the jupiter-page and be sure that you can create two types of netebooks: 
  - python
  - R

Create new notebooks of each type, in the opened window write `x = 0` in the first cell and click "Run".

If R kernel doesn't work, 
- uninstall it
```bash
jupyter kernelspec uninstall ir
```
- follow the [instruction](https://github.com/IRkernel/IRkernel).


