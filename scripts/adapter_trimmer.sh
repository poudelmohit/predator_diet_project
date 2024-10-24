#!/bin/bash

# Make sure trimmomatic is installed and can be accessed with the command trimmomatic
# You might want to uncomment the following line if you want to check parameters and options
# trimmomatic # Just checking the parameters and options

# Change to the directory containing raw reads
cd working_data/ohio_raw_data || { echo "Directory not found"; exit 1; }

# Create an output directory for trimmed files if it doesn't already exist
mkdir -p ../trimmomatic_outputs

# Trimming all files using a for loop
for filename in *_R1_001.fastq.gz; do
    r1=$filename
    r2=$(echo "$filename" | sed 's/R1/R2/') 
    trimmed_r1=$(echo "$r1" | sed 's/^/trimmed_/')
    trimmed_r2=$(echo "$r2" | sed 's/^/trimmed_/') 
    failed_r1=$(echo "$r1" | sed 's/^/trim_failed_/') 
    failed_r2=$(echo "$r2" | sed 's/^/trim_failed_/')

    # Run Trimmomatic
    trimmomatic PE -threads 6  -summary ../../output/trimmomatic.summary \
    "$r1" "$r2" \
    "../trimmomatic_outputs/$trimmed_r1" "../trimmomatic_outputs/$failed_r1" \
    "../trimmomatic_outputs/$trimmed_r2" "../trimmomatic_outputs/$failed_r2" \
    SLIDINGWINDOW:4:15 MINLEN:25 ILLUMINACLIP:../../metadata/ohio_samples_adapters.txt:2:40:15
    
    # Log the output for clarity (optional)
    echo "Processed: $r1 and $r2"

    # changing directory back to main project path:
    cd ..
done

 