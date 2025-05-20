# 4_data_frames/walkthrough.R --------------------------------------------
# Purpose : Build, inspect, subset, and extend data frames (and tibbles).
# Usage   : Run line-by-line with Ctrl/Cmd + Enter, or source() the script.

## 0. Building a data frame ----------------------------------------------

df <- data.frame(
  model = rownames(mtcars),     # character column
  mpg   = mtcars$mpg,           # numeric column
  cyl   = mtcars$cyl            # numeric column
)
str(df)                         # compact structure view

## 1. Column access -------------------------------------------------------

df$mpg               # $ by name
df[["cyl"]]          # [[ by name (returns vector)
df[ , "model"]       # [, row-all, col-by-name

## 2. Row & column indexing ----------------------------------------------

df[1, ]              # first row
df[ , 1:2]           # first two columns
df[df$mpg > 25, ]    # logical mask on rows
df[ -c(1:15), ]      # drop first 15 rows

## 3. Recycling when adding a column -------------------------------------

df$constant <- 1          # length-1 vector recycled across 32 rows
df$kpl      <- df$mpg * 0.425144   # new col by arithmetic

## 4. Modifying by position ----------------------------------------------

df[df$model == "Fiat X1-9", "cyl"] <- 4  # overwrite a single cell

## 5. Creating a tibble (optional) ----------------------------------------

library(tibble)           # if installed
tb <- as_tibble(df)       # prints with nicer summary
tb$mpg                   # identical access pattern

# End of walkthrough ------------------------------------------------------
