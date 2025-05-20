# stats_tester.R -----------------------------------------------------------
library(phytools) # phylosig()
library(geiger) # fitContinuous()

source("util/imaginaryPhyloTools.R") # your data + plotting helpers

## 1. make a reproducible “student” data set -------------------------------
dat <- generate_creature_lambda_data(
  student_id = 200,
  num_creatures = 200,
  lambda_method = "internal"
)

cat("\nTrue λ =", dat$true_target_lambda, "   (trait:", dat$trait_name, ")\n\n")

## 2. re-estimate λ with phytools::phylosig --------------------------------
fit_phytools <- phylosig(
  dat$lambda_tree,
  dat$trait_data,
  method = "lambda",
  test = TRUE
)

cat(
  "phylosig() MLE λ =",
  round(fit_phytools$lambda, 3),
  "   LR-test P =",
  formatC(fit_phytools$P, digits = 3),
  "\n"
)

## profile-likelihood 95-% CI


logL_fixed_lambda <- function(tree, trait, lambda){
  tr <- phytools:::lambdaTree(tree, lambda = lambda)   # rescale branches
  n  <- length(trait)
  C  <- vcv(tr)                                        # variance–cov matrix
  mu <- mean(trait)                                    # ML mean under BM
  resid <- trait - mu
  log_detC <- determinant(C, logarithm = TRUE)$modulus
  quad      <- t(resid) %*% solve(C, resid)
  logL <- -0.5 * (log_detC + quad + n * log(2*pi))
  as.numeric(logL)
}

lambda_grid <- seq(0, 4, by = 0.05)
logL_vec <- sapply(lambda_grid, logL_fixed_lambda,
                   tree = dat$lambda_tree,
                   trait = dat$trait_data)

plot(lambda_grid, logL_vec, type = "l")
abline(h = max(logL_vec) - 1.92, col = 2, lty = 2)
ci95 <- range(lambda_grid[logL_vec >= max(logL_vec) - 1.92])
cat("95 % CI:", round(ci95, 3), "\n")

## 3. same thing with geiger::fitContinuous -------------------------------
fit_geiger <- fitContinuous(
  dat$lambda_tree,
  dat$trait_data,
  model = "lambda",
  ncores = 4
) # set >1 if you have parallel BLAS

cat("geiger::fitContinuous() MLE λ =", round(fit_geiger$opt$lambda, 3), "\n")
