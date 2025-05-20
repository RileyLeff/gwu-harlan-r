# Goal: return the *smallest* N model IDs (starting at 1) that show
# significant λ > 0 when each is simulated with a fixed sample size.

source("util/riley_phylo_tools.R")

find_significant_ids <- function(N, n_species = 50, alpha = 0.05) {
  good_ids <- integer(0)
  id       <- 1
  while (length(good_ids) < N) {
    dat  <- generate_tree(id, n_species = n_species)
    pval <- get_stats(dat$tree, dat$trait)$p_value
    if (!is.na(pval) && pval < alpha) good_ids <- c(good_ids, id)
    id <- id + 1
  }
  good_ids
}

# Example: first 3 significant models with 60 species each
ids <- find_significant_ids(N = 3, n_species = 60)
cat("Significant IDs:", paste(ids, collapse = ", "), "\n")
