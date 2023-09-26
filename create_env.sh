conda create --name gwas python=3.7.5
conda activate gwas
conda config --env --add channels conda-forge
# conda config --env --add channels defaults
conda config --env --add channels r
# conda install jupyter
pip install notebook -y
pip install limix==3.0.3 -y
conda install -c conda-forge r-base=4.0.5 -y
conda install r-ggplot2 -y
conda install r-maps -y
conda install r-lattice -y
conda install r-irkernel -y
