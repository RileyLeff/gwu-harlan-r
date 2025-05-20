# imaginaryPhyloTools_fixed.R ---------------------------------------------
if (!requireNamespace("ape", quietly = TRUE))
  stop("package 'ape' not installed")
if (!requireNamespace("phytools", quietly = TRUE))
  stop("package 'phytools' not installed")

library(ape)
library(phytools)

generate_creature_lambda_data <- function(
  student_id,
  num_creatures = 20,
  lambda_method = c("internal", "geiger", "phylolm"),
  local_seed = TRUE
) {
  ## -------- optional local RNG scope ------------------------------------
  if (local_seed) {
    old_seed <- if (exists(".Random.seed", .GlobalEnv, inherits = FALSE))
      get(".Random.seed", .GlobalEnv) else NULL
    on.exit(
      {
        if (!is.null(old_seed))
          assign(".Random.seed", old_seed, envir = .GlobalEnv)
      },
      add = TRUE
    )
    set.seed(student_id)
  }

  lambda_method <- match.arg(lambda_method)
  true_lambda <- round(runif(1), 2) # U(0,1) but reproducible

  ## -------- species names -----------------------------------------------
  pref <- c("Glim", "Snarp", "Woot", "Zorp", "Floo", "Gibble")
  suff <- c("lefoot", "wing", "snout", "bert", "zoot", "skib")
  tips <- make.unique(
    paste0(
      sample(pref, num_creatures, TRUE),
      sample(suff, num_creatures, TRUE),
      seq_len(num_creatures)
    )
  )

  ## -------- base tree *without* tampering with ape::compute.brlen --------
  base_tree <- rtree(num_creatures, tip.label = tips)

  ## -------- optional Grafen rescale (safe) ------------------------------
  #  ape::compute.brlen() needs method="Grafen" *exactly*:
  base_tree <- compute.brlen(base_tree, method = "Grafen", power = 0.5)

  ## -------- Pagel λ transformation --------------------------------------
  lambda_tree <- switch(
    lambda_method,
    internal = phytools:::lambdaTree(base_tree, true_lambda),
    geiger = {
      if (!requireNamespace("geiger", quietly = TRUE))
        stop("install.packages('geiger') or choose lambda_method='internal'")
      geiger::rescale(base_tree, model = "lambda", lambda = true_lambda)
    },
    phylolm = {
      if (!requireNamespace("phylolm", quietly = TRUE))
        stop("install.packages('phylolm') or choose lambda_method='internal'")
      phylolm::transf.branch.lengths(
        base_tree,
        model = "lambda",
        parameters = list(lambda = true_lambda)
      )$tree
    }
  )

  ## -------- simulate trait ----------------------------------------------
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

###############################################################################
#' Plot a λ-scaled phylogeny with a continuous trait mapped to branch colours
#'
#' A ggplot/ggtree wrapper that paints every branch of a phylogeny according to
#' a continuous trait, adds 45-degree tip labels, and places a single Viridis
#' colour bar beneath the tree.
#'
#' The function **never alters branch lengths**; extra room for tip labels is
#' supplied with an \code{offset} in \code{geom_tiplab()}, leaving the biology
#' intact.
#'
#' @param tree          A \code{phylo} object whose branch lengths already
#'                      reflect any Pagel‐λ transformation.
#' @param trait         Named numeric vector; names **must match**
#'                      \code{tree$tip.label}.
#' @param trait_name    Character string for the colour-bar title.
#' @param lambda_value  Numeric; the λ applied to \code{tree}. Printed in the
#'                      plot title.  Default \code{NA} (omits λ from title).
#' @param label_angle   Rotation angle (degrees) for tip labels. Default \code{45}.
#' @param label_size    Font size for tip labels (ggplot2 size units). Default \code{3}.
#' @param label_offset  Horizontal distance (in branch-length units) between the
#'                      terminal node and its label.  By default, 2 % of the tree
#'                      height (\code{0.02 * max(nodeHeights(tree))}).
#'
#' @return A \code{ggplot} object that can be printed, modified, or exported
#'         with \code{ggsave()}.
#'
#' @examples
#' p <- plot_creature_trait(tree         = dat$lambda_tree,
#'                          trait        = dat$trait_data,
#'                          trait_name   = dat$trait_name,
#'                          lambda_value = dat$true_target_lambda)
#' print(p)
#'
#' @export
###############################################################################
plot_creature_trait <- function(
  tree,
  trait,
  trait_name,
  lambda_value = NA_real_,
  label_angle = 45,
  label_size = 3,
  label_offset = NULL
) {
  ## ---- dependencies -------------------------------------------------------
  for (pkg in c("ggtree", "treeio", "viridisLite")) {
    if (!requireNamespace(pkg, quietly = TRUE))
      stop("plot_creature_trait() requires package '", pkg, "'.")
  }
  library(ggtree) # loads ggplot2 internally
  library(treeio)
  library(ggplot2)
  library(viridisLite) # colour palette
  library(patchwork) # easy plot layout
  library(tibble) # for enframe()
  library(phytools)

  ## ---- quick checks -------------------------------------------------------
  if (!inherits(tree, "phylo")) stop("'tree' must be a phylo object.")
  if (!is.numeric(trait) || is.null(names(trait)))
    stop("'trait' must be a *named* numeric vector.")
  if (!all(tree$tip.label %in% names(trait)))
    stop("Some tip labels are missing in 'trait'.")

  ## ---- default offset: 2 % of tree height --------------------------------
  if (is.null(label_offset)) {
    tree_height <- max(nodeHeights(tree))
    label_offset <- 0.02 * tree_height
  }

  ## ---- merge trait with tree data ----------------------------------------
  trait_df <- data.frame(label = names(trait), value = as.numeric(trait))

  g <- ggtree(tree, aes(color = value), size = 0.8) %<+%
    trait_df +
    geom_tiplab(
      angle = label_angle,
      hjust = 0,
      size = label_size,
      offset = label_offset
    ) +

    scale_color_viridis_c(
      name = trait_name,
      guide = guide_colourbar(
        barheight = grid::unit(4, "mm"),
        barwidth = grid::unit(90, "mm"),
        title.position = "top",
        title.hjust = 0.5,
        label.position = "bottom"
      )
    ) +

    ggtitle(
      if (is.na(lambda_value)) trait_name else
        sprintf("%s (λ = %.2f)", trait_name, lambda_value)
    ) +

    theme_tree2() +
    theme(
      legend.position = "bottom",
      plot.title = element_text(hjust = 0.5, face = "bold")
    )

  return(g)
}
