# 5_read_write/challenge_solution.R --------------------------------------

## 1
cdat <- read.csv("data/chillin.csv", stringsAsFactors = FALSE)

## 2
cdat$chill_score <- (cdat$health + cdat$hunger) / 2

## 3
sub <- cdat[cdat$location == "SEH", ]
dir.create("output", showWarnings = FALSE)
write.csv(sub, file.path("output", "chillin_seh.csv"), row.names = FALSE)

## 4
test <- read.csv("output/chillin_seh.csv", stringsAsFactors = FALSE)
stopifnot(nrow(test) == 2)

print(test)
