# FINAL CHALLENGE 3 -------------------------------------------------------
# Goal: Write a FUNCTION find_sig_ids(N, sample_size, alpha = 0.05)
#       that returns the **lowest N unique model IDs** whose lambda
#       is significantly > 0 (LR test) at the specified sample_size.
#
# • Use a simple while-loop that climbs id = 1, 2, 3, ...
# • Stop when 'hits' reaches N.
# • Inside the loop:
#     – generate_tree(id, n_species = sample_size)
#     – get_stats()
#     – if (p < alpha) store id and move on.
#
# Optional upgrade:
#   return a data.frame with columns id, lambda_ML, p_value.

library(ape)
library(phytools)
source("util/riley_phylo_tools.R")

find_sig_ids <- function(N, sample_size = 50, alpha = 0.05) {
  hits <- integer(0)        # store qualifying IDs
  id   <- 0

  while (length(hits) < N) {
    id <- id + 1
    dat <- generate_tree(id, n_species = sample_size)
    res <- get_stats(dat$tree, dat$trait)

    if (res$p_value < alpha) {
      hits <- c(hits, id)
    }
  }

  hits
}

# example call ------------------------------------------------------------
sig_ids <- find_sig_ids(N = 5, sample_size = 60)
print(sig_ids)
