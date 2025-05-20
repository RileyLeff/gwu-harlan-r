# imaginaryPhyloTools.R  (May-2025 refresh)

if (!requireNamespace("ape", quietly = TRUE)) stop("ape not installed")
if (!requireNamespace("phytools", quietly = TRUE))
  stop("phytools not installed")

library(ape)
library(phytools)

#' Generate a cartoon clade with a Pagel-λ transform
#'
#' No global RNG side-effects: the old .Random.seed is restored on exit.
#'
#' @param student_id      integer used as a private seed
#' @param num_creatures   number of tips (default 20)
#' @param lambda_method   "internal", "geiger", or "phylolm"
#' @return list (tree, λ-scaled tree, trait, true λ, etc.)
generate_creature_lambda_data <- function(
  student_id,
  num_creatures = 20,
  lambda_method = c("internal", "geiger", "phylolm")
) {
  ## ---------- make all RNG activity local ----------
  old_seed <- if (exists(".Random.seed", .GlobalEnv, inherits = FALSE))
    get(".Random.seed", .GlobalEnv) else NULL
  on.exit(
    if (!is.null(old_seed)) assign(".Random.seed", old_seed, envir = .GlobalEnv)
  )

  set.seed(student_id) # reproducibility keyed to the student id

  lambda_method <- match.arg(lambda_method)
  true_lambda <- round(runif(1, 0, 1), 2) # less predictable than modulus

  ## ---------- silly names ----------
  pref <- c("Glim", "Snarp", "Woot", "Zorp", "Floo", "Gibble")
  suff <- c("lefoot", "wing", "snout", "bert", "zoot", "skib")
  tips <- make.unique(paste0(
    sample(pref, num_creatures, TRUE),
    sample(suff, num_creatures, TRUE),
    seq_len(num_creatures)
  ))

  ## ---------- base tree ----------
  base_tree <- compute.brlen(
    rtree(num_creatures, tips),
    method = "Grafen",
    power = 0.5
  )

  ## ---------- λ transform ----------
  lambda_tree <- switch(
    lambda_method,
    internal = phytools:::lambdaTree(base_tree, true_lambda),
    geiger = {
      if (!requireNamespace("geiger", quietly = TRUE))
        stop("geiger not installed")
      geiger::rescale(base_tree, "lambda", true_lambda)
    },
    phylolm = {
      if (!requireNamespace("phylolm", quietly = TRUE))
        stop("phylolm not installed")
      phylolm::transf.branch.lengths(
        base_tree,
        model = "lambda",
        parameters = list(lambda = true_lambda)
      )$tree
    }
  )

  ## ---------- trait ----------
  trait <- fastBM(lambda_tree, sig2 = runif(1, 0.5, 2), a = runif(1, -1, 1))

  trait_name <- sample(
    c(
      "Rizz_Frequency_Hz",
      "Simp_Devotion_Scale",
      "Aura_Intensity_Lumens",
      "Vibe_Wavelength_m",
      "Keryn_Loyalty_mg"
    ),
    1
  )

  list(
    student_id = student_id,
    base_tree = base_tree,
    lambda_tree = lambda_tree,
    trait_name = trait_name,
    trait_data = trait,
    true_target_lambda = true_lambda
  )
}

cat("imaginaryPhyloTools.R loaded – call generate_creature_lambda_data().\n")
