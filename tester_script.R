## tester_imaginaryPhyloTools.R  ------------------------

source("util/imaginaryPhyloTools.R") # same folder

dat <- generate_creature_lambda_data(
  2,
  num_creatures = 50,
  lambda_method = "internal"
)

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
## ---------- coloured trait map with simple in-frame legend -----
library(viridisLite)

cm <- contMap(dat$lambda_tree, dat$trait_data, plot = FALSE, legend = FALSE)

cm <- setMap(cm, viridisLite::viridis(n = length(cm$cols)))

plot(
  cm,
  legend = FALSE,
  fsize = 0.6,
  lwd = 3,
  main = sprintf("%s   (λ = %.2f)", dat$trait_name, dat$true_target_lambda)
)

## ----- add colour bar bottom-left *inside* plot ----------------
op <- par(xpd = TRUE) # allow drawing anywhere on device
on.exit(par(op)) # restore immediately afterwards

usr <- par("usr") # plot limits: c(x1,x2,y1,y2)

bar_len <- 0.35 * diff(usr[1:2]) # 35 % of plot width
x_left <- usr[1] + 0.05 * diff(usr[1:2])
y_bot <- usr[3] + 0.95 * diff(usr[3:4])

add.color.bar(
  bar_len,
  cm$cols,
  title = sprintf("%s  (λ = %.2f)", dat$trait_name, dat$true_target_lambda),
  subtitle = "",
  lims = round(cm$lims, 2),
  prompt = FALSE,
  x = x_left,
  y = y_bot,
  fsize = 0.8
)

par(xpd = FALSE) # (redundant after on.exit, but explicit)

library(ggplot2)
library(ggtree) # loads ggplot2 automatically
library(treeio) # for %<+% operator
library(viridisLite) # colour palette
library(patchwork) # easy plot layout
library(tibble) # for enframe()

tree <- dat$lambda_tree # λ-scaled phylo object
trait <- data.frame(label = names(dat$trait_data), value = dat$trait_data)

p_tree <- ggtree(tree, aes(color = value), size = 0.8) %<+%
  trait +
  scale_color_viridis_c(name = dat$trait_name) + # continuous legend
  geom_tiplab(angle = 45, hjust = 0, size = 3) + # tilted labels
  theme_tree2() + # axes-off theme
  ggtitle(sprintf("%s  (λ = %.2f)", dat$trait_name, dat$true_target_lambda)) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    legend.position = "none"
  ) # hide legend here


# build a 1-row data frame with evenly spaced colours
n_cols <- 100
bar_df <- tibble(
  x = seq_len(n_cols),
  y = 1,
  z = seq(-1, 1, length.out = n_cols)
)

p_bar <- ggplot(bar_df, aes(x, y, fill = z)) +
  geom_tile() +
  scale_fill_viridis_c(
    name = dat$trait_name,
    limits = range(bar_df$z),
    guide = guide_colourbar(
      title.position = "top",
      title.hjust = 0.5,
      barheight = unit(4, "mm"),
      barwidth = unit(90, "mm")
    )
  ) +
  theme_void() +
  theme(
    legend.position = "bottom",
    legend.title = element_text(face = "bold"),
    plot.margin = margin(t = -5, r = 20, b = 0, l = 20)
  )

final_plot <- p_tree /
  p_bar + # “/” = vertical stack (patchwork)
  plot_layout(heights = c(20, 1))
print(final_plot)

final_plot
