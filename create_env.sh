env_name=gwas

conda create --name $env_name python=3.7.5 -y
conda activate $env_name
# conda config --env --add channels conda-forge
conda config --add channels conda-forge
conda config --set channel_priority strict
# conda config --env --add channels r
pip install notebook
pip install limix==3.0.3
conda install -c conda-forge r-base=4.0.5 -y
conda install r-ggplot2 -y
conda install r-maps -y
conda install r-lattice -y
conda install r-irkernel -y