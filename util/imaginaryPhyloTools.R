# imaginaryPhyloTools_fixed.R ---------------------------------------------
if (!requireNamespace("ape",      quietly = TRUE)) stop("package 'ape' not installed")
if (!requireNamespace("phytools", quietly = TRUE)) stop("package 'phytools' not installed")

library(ape);  library(phytools)

generate_creature_lambda_data <- function(student_id,
                                          num_creatures = 20,
                                          lambda_method = c("internal",
                                                            "geiger",
                                                            "phylolm"),
                                          local_seed   = TRUE) {

  ## -------- optional local RNG scope ------------------------------------
  if (local_seed) {
    old_seed <- if (exists(".Random.seed", .GlobalEnv, inherits = FALSE))
                  get(".Random.seed", .GlobalEnv) else NULL
    on.exit({
      if (!is.null(old_seed)) assign(".Random.seed", old_seed, envir = .GlobalEnv)
    }, add = TRUE)
    set.seed(student_id)
  }

  lambda_method <- match.arg(lambda_method)
  true_lambda   <- round(runif(1), 2)             # U(0,1) but reproducible

  ## -------- species names -----------------------------------------------
  pref <- c("Glim","Snarp","Woot","Zorp","Floo","Gibble")
  suff <- c("lefoot","wing","snout","bert","zoot","skib")
  tips <- make.unique(
            paste0(sample(pref, num_creatures, TRUE),
                   sample(suff, num_creatures, TRUE),
                   seq_len(num_creatures)))

  ## -------- base tree *without* tampering with ape::compute.brlen --------
  base_tree <- rtree(num_creatures, tip.label = tips)

  ## -------- optional Grafen rescale (safe) ------------------------------
  #  ape::compute.brlen() needs method="Grafen" *exactly*:
  base_tree <- compute.brlen(base_tree, method = "Grafen", power = 0.5)

  ## -------- Pagel λ transformation --------------------------------------
  lambda_tree <- switch(lambda_method,
    internal = phytools:::lambdaTree(base_tree, true_lambda),
    geiger   = {
      if (!requireNamespace("geiger", quietly = TRUE))
        stop("install.packages('geiger') or choose lambda_method='internal'")
      geiger::rescale(base_tree, model = "lambda", lambda = true_lambda)
    },
    phylolm  = {
      if (!requireNamespace("phylolm", quietly = TRUE))
        stop("install.packages('phylolm') or choose lambda_method='internal'")
      phylolm::transf.branch.lengths(base_tree,
        model = "lambda",
        parameters = list(lambda = true_lambda))$tree
    })

  ## -------- simulate trait ----------------------------------------------
  trait <- fastBM(lambda_tree,
                  sig2 = runif(1, 0.5, 2),
                  a    = runif(1, -1, 1))

  trait_name <- sample(c("Rizz_Frequency_Hz", "Simp_Devotion_Scale",
                         "Aura_Intensity_Lumens", "Vibe_Wavelength_m",
                         "Keryn_Loyalty_mg"), 1)

  list(student_id         = student_id,
       base_tree          = base_tree,
       lambda_tree        = lambda_tree,
       trait_name         = trait_name,
       trait_data         = trait,
       true_target_lambda = true_lambda)
}
