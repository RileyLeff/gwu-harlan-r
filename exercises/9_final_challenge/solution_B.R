# Goal: for a given model id, find the *minimum* number of species
# needed so that the λ test is significant at α = 0.05.

source("util/riley_phylo_tools.R")

min_n_for_signif <- function(id, alpha = 0.05,
                             start_n = 10, step = 5, max_n = 200) {
  for (n in seq(start_n, max_n, by = step)) {
    dat  <- generate_tree(id, n_species = n)
    pval <- get_stats(dat$tree, dat$trait)$p_value
    if (!is.na(pval) && pval < alpha) return(n)
  }
  NA_integer_  # didn’t reach significance within max_n
}

# Example: model id 17
result_n <- min_n_for_signif(17)
cat("Minimum n_species for id 17:", result_n, "\n")
