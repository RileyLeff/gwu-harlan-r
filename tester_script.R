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

# # ---------- coloured trait map ----------
# cm <- contMap(dat$lambda_tree, dat$trait_data, plot = FALSE, legend = FALSE)

## -------- contMap with fixed legend placement -----------------
old_par <- par(no.readonly = TRUE)      # snapshot graphics settings
on.exit(par(old_par))                   # restore when function exits

# enlarge bottom margin a little
par(mar = c(5.5, 4, 4, 2) + 0.1)        # bottom, left, top, right

cm <- contMap(dat$lambda_tree, dat$trait_data,
              plot   = FALSE,
              legend = FALSE)

cm <- setMap(cm, viridisLite::viridis(n = length(cm$cols)))

plot(cm, legend = FALSE, fsize = 0.6, lwd = 3,
     main  = sprintf("%s   (λ = %.2f)",
                     dat$trait_name, dat$true_target_lambda))

## ----- add static colour bar underneath -----------------------
par(xpd = TRUE)                         # allow drawing in the margin

usr <- par("usr")
bar_len <- 0.4 * diff(usr[1:2])         # 40 % of plot width
x_left  <- usr[1] + 0.3 * diff(usr[1:2])
y_bot   <- usr[3] - 0.055 * diff(usr[3:4])

add.color.bar(bar_len,
              cm$cols,
              title   = paste(dat$trait_name,
                              sprintf("(λ = %.2f)", dat$true_target_lambda)),
              lims    = round(cm$lims, 2),
              prompt  = FALSE,
              x       = x_left,
              y       = y_bot,
              fsize   = 0.8)

par(xpd = FALSE)                        # clip again for future plots
