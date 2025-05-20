# FINAL CHALLENGE 1 -------------------------------------------------------
# Goal: Find the FIRST model ID (searching upward from 1) that contains
#       **four consecutive** simulations classified into the SAME hidden
#       λ-strategy class.
#
# Strategy hint -----------------------------------------------------------
# • For each id, call generate_tree(id, n_species = 100)          # <- fixed n
# • Then run get_stats(tree, trait) and classify the result
#     >  high : lambda_ML > 0.8
#     >   mid : 0.3 <= lambda_ML <= 0.8
#     >   low : lambda_ML < 0.3
# • Keep a sliding window (length 4) of the most recent classes in a variable.
# • Stop (break) once the window elements are all identical.

# starter scaffold --------------------------------------------------------
library(ape)
library(phytools)

source("util/riley_phylo_tools.R")   # assumes file is in your working dir

window <- character(0)          # recent classes
id     <- 0                     # will start at 1 in the loop

repeat {
  # TODO: increment id, generate data, compute lambda & class ---------
  # 1. id <- id + 1
  # 2. dat <- generate_tree(id)
  # 3. sts <- get_stats(dat$tree, dat$trait)
  # 4. class <- ...  # use thresholds above
  # 5. update 'window' to keep the last 4 classes
  # 6. if (length(window) == 4 && length(unique(window)) == 1) break
}

cat("First qualifying ID is:", id, "\n")
