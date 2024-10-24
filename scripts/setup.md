# Getting ready for the project:

## Creating project directories:

    # Whole project in my device is saved as: ~/thesis_project/predator_diet_project

## Activating git:
    
    touch .gitignore
    git init
    # manually edited .gitignore to avoid backup of large files.

## Creating subdirectories:

    mkdir -p raw_data/ working_data/ metadata/ scripts/scripts.md tools/ output/ resources/ media/
    # Content of the current file is saved as scripts/scripts.md

## Installing conda

    cd tools
    wget https://repo.anaconda.com/archive/Anaconda3-2024.06-1-Linux-x86_64.sh
    chmod +x Anaconda3-*.sh
    bash Anaconda3-*.sh -b -p ~/anaconda3 # running installer
    ~/anaconda3/bin/conda init # adding to PATH
    source ~/.bashrc # restarting source to apply changes
    conda --version # verifying installation

## Creating dedicated conda env for this project

    conda env list
    conda create -n diet_project -y
    conda activate diet_project

## Creating a different env for R packages for this project

    conda deactivate
    conda create -n diet_r r-base r-essentials -y
    conda activate diet_r
    conda install fastqcr -y


### Installing fastqc in conda env

    conda install -c bioconda fastqc -y
    fastqc --version >> requirements.txt

### Installing trimmomatic in conda env

    conda install -c bioconda trimmomatic -y
    echo "trimmomatic" $(trimmomatic -version) >> requirements.txt

    cat requirements.txt

### Installing vsearch to merge paired ends (also useful for other tasks)

    conda install -c bioconda vsearch -y
    vsearch --version 2> error.log > /dev/null && cat error.log | head -n 1 >> requirements.txt
    cat requirements.txt
    

    
## Obtaining and processing raw data:


## Creating a file with adapter sequences for ohio samples:

    echo "# name_of_adapters   sequences" > ../../metadata/ohio_samples_adapters.txt

    echo "cytb_f    CCATCCAACATCTCAGCATGATGAAA" >> ../../metadata/ohio_samples_adapters.txt
    echo "cytb_r    CCCTCAGAATGATATTTGTCCTCA" >> ../../metadata/ohio_samples_adapters.txt
    echo "12S_f    ACTGGGATTAGATACCCC" >> ../../metadata/ohio_samples_adapters.txt
    echo "12S_r    TAGAACAGGCTCCTCTAG" >> ../../metadata/ohio_samples_adapters.txt

    cat ../../metadata/ohio_samples_adapters.txt

## R script to summarize fastqc reports:
    
  






