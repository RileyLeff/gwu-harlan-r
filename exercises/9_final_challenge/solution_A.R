# Goal: first occurrence—starting at id 1—of FOUR consecutive models
# that belong to the *same* hidden “strategy” class (high / mid / low λ).

source("util/riley_phylo_tools.R")

# ----- helper: classify a model by its fitted λ -------------------------
# We avoid using the hidden .class_id() by estimating λ from the data
# and binning it.  Cut-points chosen from generate_tree() spec.
strategy <- function(id, n_species = 50, lam_mid = 0.5) {
  dat  <- generate_tree(id, n_species, lam_mid)
  fit  <- get_stats(dat$tree, dat$trait)$lambda_ML
  if (fit > 0.8)    "high"
  else if (fit < 0.2) "low"
  else               "mid"
}

# ----- search -----------------------------------------------------------
run_target  <- 4           # number of consecutive hits
run_length  <- 1
prev_strat  <- strategy(1)
for (id in 2:1e5) {        # generous upper bound
  this_strat <- strategy(id)
  if (this_strat == prev_strat) {
    run_length <- run_length + 1
    if (run_length == run_target) {
      start_id <- id - run_target + 1
      cat("First run of", run_target, "consecutive", this_strat,
          "models: IDs", start_id, "to", id, "\n")
      break
    }
  } else {
    run_length <- 1
    prev_strat <- this_strat
  }
}
