# 5_read_write/demo.R -----------------------------------------------------

chillin <- read.csv("data/chillin.csv", stringsAsFactors = FALSE)
chillin$wellness <- chillin$health - chillin$hunger
dir.create("output", showWarnings = FALSE)
write.csv(chillin, file.path("output", "chillin_clean.csv"), row.names = FALSE)
check <- read.csv("output/chillin_clean.csv", stringsAsFactors = FALSE)
head(check)
