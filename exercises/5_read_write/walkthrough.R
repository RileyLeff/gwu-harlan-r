# 5_read_write/walkthrough.R ---------------------------------------------
# Purpose : Read data/chillin.csv, do a light transformation,
#           and write the result to output/chillin_clean.csv
#           using base R functions only.
# Usage   : Run line-by-line (Ctrl/Cmd + Enter) or source() the script.

## 0. Confirm working directory ------------------------------------------

getwd()                               # where am I?  # :contentReference[oaicite:1]{index=1}

## 1. Read the CSV --------------------------------------------------------

chillin <- read.csv("data/chillin.csv",
                    stringsAsFactors = FALSE)      # returns data.frame  # :contentReference[oaicite:2]{index=2}
str(chillin)

## 2. Light transformation -----------------------------------------------

# Add a simple 'wellness' score: health - hunger (arbitrary example)
chillin$wellness <- chillin$health - chillin$hunger

## 3. Create an output folder if needed ----------------------------------

dir.create("output", showWarnings = FALSE)

## 4. Write the cleaned file ---------------------------------------------

write.csv(chillin,
          file = file.path("output", "chillin_clean.csv"),
          row.names = FALSE)                       # base writer  # :contentReference[oaicite:3]{index=3}

## 5. Read it back to verify ---------------------------------------------

check <- read.csv("output/chillin_clean.csv", stringsAsFactors = FALSE)
head(check)

# End of walkthrough ------------------------------------------------------
