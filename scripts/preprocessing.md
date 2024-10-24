# From raw reads to adapter trimmed reads:

## moving raw_data to working_data:
    
    cp ~/Downloads/OneDrive_* raw_data
    cd raw_data && unzip ./*.zip
    
    mkdir ../working_data/ohio_raw_data/
    find . -type f -name "*.fastq.gz" -exec cp {} -p ../working_data/ohio_raw_data/ \;

## Checking how the data looks like:

    cd ../working_data/ohio_raw_data/

    ls *.fastq.gz | wc -l # total 516 files
    ls *_R1_001.fastq.gz | wc -l # 258 forward reads 
    ls *_R2_001.fastq.gz | wc -l # 258 reverse reads

    echo -e "# Basic Information on Ohio Samples\n\n## Number of total files from Ohio:" > ../../metadata/about_ohio_samples.md
    echo -e "### We have total $(ls *.fastq.gz | wc -l) files from Ohio\n" > ../../metadata/about_ohio_samples.md
    echo -e "### We have total $(ls *_R1_001.fastq.gz | wc -l) files for forward reads from Ohio\n" >> ../../metadata/about_ohio_samples.md
    echo -e "### We have total $(ls *_R2_001.fastq.gz | wc -l) files for reverse reads from Ohio\n" >> ../../metadata/about_ohio_samples.md

### Adding extra comments in the metadata/about_ohio_samples.md file:
    echo -e "## Lets see if certain sample was amplified with just one marker or both.\n
    Remeber, each marker here is generating two reads (forward and reverse).\n
    So, a file showing only two reads means, it was amplified with only 1 marker (cytb or 12S).\n
    However, if the count is 4 , it means that sample was amplified with both markers.\n
    Value in first column below gives count, followed by prefix in sample id:\n" >> ../../metadata/about_ohio_samples.md


    ls | cut -d'_' -f1 | sort | uniq -c >> ../../metadata/about_ohio_samples.md

    cat ../../metadata/about_ohio_samples.md


## Checking quality of raw_ohio_reads:
    
    conda activate diet_project


    mkdir -p ../../output/initial_fastqc_reports
    
    fastqc *.fastq.gz -threads 8  --quiet  --adapters ../../metadata/ohio_samples_adapters.txt -o ../../output/initial_fastqc_reports/
    # Here I have specified adapter sequences in the file [ohio_samples_adapters.txt] and also the output directories to save fastqc reports.
    ## Says failed to process due to probably memory issue. 

## Just checking with normal fastqc (without multiple parameters, to make specifying adapters is not the issue)
    fastqc *.fastq.gz -threads 6 --quiet -o ../../output/initial_fastqc_reports/
    ls ../../output/initial_fastqc_reports/*.zip | wc -l

## Trimming low quality reads:

    chmod +x scripts/adapter_trimmer.sh
    scripts/adapter_trimmer.sh