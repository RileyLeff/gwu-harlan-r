# FINAL CHALLENGE 2 -------------------------------------------------------
# Goal: For the model ID stored in 'target_id', determine the MINIMUM
#       number of species (n_species) required for the LR test of
#       lambda > 0 to reach significance (p < 0.05).
#
# Strategy hint -----------------------------------------------------------
# • Start at a small sample (e.g. 10), then grow by +5 each iteration.
# • Use get_stats() to grab p-value; break when p < 0.05.
# • Record both the critical n_species and the lambda_ML you found.

library(ape)
library(phytools)
source("util/riley_phylo_tools.R")

target_id <- 17           # <-- change to explore other IDs
n          <- 5           # starting sample size
step       <- 5

repeat {
  n <- n + step
  dat  <- generate_tree(target_id, n_species = n)
  res  <- get_stats(dat$tree, dat$trait)

  if (res$p_value < 0.05) {
    break   # reached significance
  }
}

cat("ID", target_id, "achieves p<0.05 at n =", n,
    "with lambda_ML =", round(res$lambda_ML, 3), "\n")
