# imaginaryPhyloTools.R  (rev. 2025-05-19)

library(ape)
library(phytools)

#' Simulate a silly clade with a continuous trait evolved under λ
#'
#' @param student_unique_value single integer seed
#' @param num_creatures       number of tips to simulate
#' @param lambda_method       "internal" (default), "geiger", or "phylolm"
#' @return list with tree, trait vector, true λ, etc.
generate_creature_lambda_data <- function(
  student_unique_value,
  num_creatures = 20,
  lambda_method = c("internal", "geiger", "phylolm")
) {
  set.seed(student_unique_value)
  lambda_method <- match.arg(lambda_method)

  ## ----- pick the true λ (0.00-1.00 by 0.01 steps) -----
  true_lambda <- round((student_unique_value %% 101) / 100, 2)

  ## ----- make cartoonish species names -----
  pref <- c("Glim", "Snarp", "Woot", "Zorp", "Floo", "Gibble")
  suff <- c("lefoot", "wing", "snout", "bert", "zoot", "skib")
  tips <- make.unique(paste0(
    sample(pref, num_creatures, TRUE),
    sample(suff, num_creatures, TRUE),
    seq_len(num_creatures)
  ))

  ## ----- base tree -----
  base_tree <- rtree(num_creatures, tip.label = tips)
  base_tree <- compute.brlen(base_tree, method = "Grafen", power = 0.5)

  ## ----- λ transformation (choose implementation) -----
  transformed_tree <- switch(
    lambda_method,
    internal = phytools:::lambdaTree(base_tree, true_lambda),
    geiger = {
      if (!requireNamespace("geiger", quietly = TRUE))
        stop(
          "Please install.packages('geiger') or use lambda_method='internal'"
        )
      geiger::rescale(base_tree, model = "lambda", lambda = true_lambda)
    },
    phylolm = {
      if (!requireNamespace("phylolm", quietly = TRUE))
        stop(
          "Please install.packages('phylolm') or use lambda_method='internal'"
        )
      phylolm::transf.branch.lengths(
        base_tree,
        model = "lambda",
        parameters = list(lambda = true_lambda)
      )$tree
    }
  )

  ## ----- simulate trait under BM on the λ-scaled tree -----
  trait <- fastBM(
    transformed_tree,
    sig2 = runif(1, 0.5, 2),
    a = runif(1, -1, 1)
  )

  ## ----- assemble output -----
  trait_name <- sample(
    c(
      "Rizz_Frequency_Hz",
      "Simp_Devotion_Scale",
      "Aura_Intensity_Lm",
      "Vibe_Wavelength_m",
      "Keryn_Loyalty_mg"
    ),
    1
  )

  list(
    student_id = student_unique_value,
    base_tree = base_tree,
    lambda_tree = transformed_tree,
    trait_name = trait_name,
    trait_data = trait,
    true_target_lambda = true_lambda
  )
}

cat("imaginaryPhyloTools.R loaded – use generate_creature_lambda_data().\n")
