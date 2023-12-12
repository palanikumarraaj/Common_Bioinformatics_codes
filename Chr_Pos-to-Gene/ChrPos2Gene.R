library(dplyr)
ona <- read.delim(file = "input.txt", header = TRUE, sep = "")
sdf <- read.delim(file = "Gene-list.txt", header = TRUE, sep = "")
sdf$X.1 <- NULL
sdf$X <- NULL
# Convert Pos column to numeric if it's not already
ona$Pos <- as.numeric(ona$Pos)

# Create an empty dataframe to store the results
result_df <- data.frame(chr = integer(), Pos = integer(), Gene = character())

# Loop through each row in ona
for (i in 1:nrow(ona)) {
  # Filter sdf based on chr
  subset_df <- sdf[sdf$Chr == ona$chr[i], ]
  
  # Check if Pos is within the range of Start and End
  within_range <- subset_df$Start <= ona$Pos[i] & ona$Pos[i] <= subset_df$End
  
  # Check if there's any match and no missing values
  if (any(within_range) && !any(is.na(within_range))) {
    match_row <- subset_df[within_range, ]
    result_df <- rbind(result_df, c(ona$chr[i], ona$Pos[i], match_row$Gene))
  }
}

# Rename the columns in the result dataframe
colnames(result_df) <- c("chr", "Pos", "Gene")
# Rename the columns in the result dataframe
write.csv(result_df, file = "Chr-Pos2Gene.csv", row.names = FALSE)
