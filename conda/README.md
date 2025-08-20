# Importing / Exporting Conda Environments
```bash
# export environment
conda env export > env.yml
# create new one from exported file
conda env create -f env.yml -n env
# update existing env
conda env update -f env.yml -n env --prune
```