

# Loading the required library
if (!requireNamespace("fastqcr", quietly = TRUE)) {
  install.packages("fastqcr", dependencies = TRUE)
}
library(fastqcr)

# Function to summarize FastQC reports
summarize_fastqc_reports <- function(fastqc_path) {
  
  # List all FastQC report zip files
  fastqc_files <- list.files(path = fastqc_path, pattern = "*.zip", full.names = TRUE)

  # Initialize an empty list to store summaries
  qc_summary_list <- list()

  # Loop through each FastQC report file and summarize
  for (file in fastqc_files) {
    # Read the FastQC report
    qc_data <- read_fastqc(file)

    # Summarize the report
    summary <- summarize_fastqc(qc_data)

    # Store the summary in the list with the file name as the key
    qc_summary_list[[basename(file)]] <- summary
  }

  # Combine all summaries into a single data frame
  combined_summary <- do.call(rbind, qc_summary_list)

  # Print the combined summary
  print(combined_summary)

  # saving the summary to a CSV file
  write.csv(combined_summary, file = "fastqc_summary.csv", row.names = FALSE)
}