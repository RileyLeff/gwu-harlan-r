## tester_imaginaryPhyloTools.R  ------------------------------

## 1.  Load your utility functions
source("util/imaginaryPhyloTools.R") # adjust path if needed

## 2.  Generate a test data-set
# pick any integer seed – students might use the last 3 digits of their ID
test_dat <- generate_creature_lambda_data(
  student_unique_value = 867,
  num_creatures = 25,
  lambda_method = "internal"
)
cat("\nTrue λ used to rescale the tree:", test_dat$true_target_lambda, "\n\n")

## quick sanity check on the trait vector
print(head(test_dat$trait_data))

## 3.  Basic tree plot (labels only) --------------------------
library(phytools) # provides plotTree() wrapper
plotTree(
  test_dat$lambda_tree,
  fsize = 0.7,
  lwd = 1.2,
  pts = FALSE,
  main = "Sample tree rescaled by Pagel's λ"
)

## 4.  Fancy continuous-trait map -----------------------------
# colour the branches by the simulated trait
# (contMap interpolates ancestral states and draws a gradient)
cm <- contMap(
  test_dat$lambda_tree,
  test_dat$trait_data,
  legend = FALSE,
  fsize = 0.6,
  plot = FALSE
) # build first so we can swap in viridis

# replace default colours with viridis if you have it installed
if (requireNamespace("viridisLite", quietly = TRUE)) {
  cm$cols[] <- viridisLite::viridis(100)
}

plot(cm, fsize = 0.6, lwd = 3)
add.color.bar(
  0.05,
  cm$cols,
  title = test_dat$trait_name,
  lims = cm$lims,
  fsize = 0.7,
  subtitle = "lower  ←   trait value   →  higher"
)
