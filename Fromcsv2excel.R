# Install and load necessary packages
if (!require("tidyverse")) install.packages("tidyverse")

# Set the path to your folder containing CSV files

# Get a list of all CSV files in the folder
csv_files <- list.files(path = ".", pattern = "\\.csv$", full.names = TRUE)

# Check if there are any CSV files
if (length(csv_files) == 0) {
  stop("No CSV files found in the specified folder.")
}

# Load the tidyverse package
library(tidyverse)

# Create a function to read each CSV file and return a data frame
read_csv_file <- function(file_path) {
  read.csv(file_path, stringsAsFactors = FALSE)
}

# Read all CSV files into a list of data frames
data_frames <- map(csv_files, read_csv_file)

# Create an Excel workbook
output_file <- "Combined_data.xlsx"
wb <- openxlsx::createWorkbook()

# Add each data frame as a sheet in the Excel workbook
for (i in seq_along(data_frames)) {
  sheet_name <- tools::file_path_sans_ext(basename(csv_files[i]))
  openxlsx::addWorksheet(wb, sheetName = sheet_name)
  openxlsx::writeData(wb, sheet = sheet_name, x = data_frames[[i]])
}

# Save the Excel workbook to a file
openxlsx::saveWorkbook(wb, output_file, overwrite = TRUE)

cat("Excel file created successfully:", output_file, "\n")
