## tester_imaginaryPhyloTools.R  ------------------------

source("util/imaginaryPhyloTools.R") # same folder

dat <- generate_creature_lambda_data(867, num_creatures = 25, lambda_method = "internal")

cat("True λ =", dat$true_target_lambda, "| trait =", dat$trait_name, "\n")

# ---------- plain tree ----------
plotTree(
  dat$lambda_tree,
  fsize = 0.75,
  lwd = 1.3,
  main = sprintf("λ-scaled tree (λ = %.2f)", dat$true_target_lambda)
)

# ---------- coloured trait map ----------
cm <- contMap(dat$lambda_tree, dat$trait_data, plot = FALSE, legend = FALSE)

## replace palette with viridis (continuous & CVD-friendly) ----
if (requireNamespace("viridisLite", quietly = TRUE)) {
  ncols <- length(cm$cols) # avoid recycling warning / striping
  cm$cols[] <- viridisLite::viridis(ncols)
}

plot(cm, fsize = 0.6, lwd = 3, main = dat$trait_name, legend = FALSE)

## draw a fixed-position colour bar (no clicking) --------------
usr <- par("usr") # plot coordinates
bar_len <- 0.12 * (usr[2] - usr[1])
x_left <- usr[1] + 0.04 * (usr[2] - usr[1])
y_bottom <- usr[3] - 0.06 * (usr[4] - usr[3])

add.color.bar(
  bar_len,
  cm$cols,
  title = "trait value",
  lims = round(cm$lims, 2),
  digits = 2,
  prompt = FALSE,
  x = x_left,
  y = y_bottom,
  fsize = 0.8,
  subtitle = sprintf("λ = %.2f", dat$true_target_lambda)
)
