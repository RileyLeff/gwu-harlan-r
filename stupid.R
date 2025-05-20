library(phytools)

## 1. Estimate Pagel λ from the simulated data -------------------
fit <- phylosig(dat$lambda_tree, dat$trait_data, method = "lambda", test = TRUE)

fit$lambda # MLE
fit$logL # log-likelihood
fit$P # P-value that λ ≠ 0

## 2. Compare to the embedded 'true' value -----------------------
cat(
  "true λ =",
  dat$true_target_lambda,
  "\nestimated λ =",
  round(fit$lambda, 2),
  "\n"
)

## 3. Plot residuals vs. phylogeny to discuss model adequacy -----
phylomorphospace(
  dat$lambda_tree,
  X = cbind(dat$trait_data, rep(0, length(dat$trait_data))),
  label = "horizontal"
)
