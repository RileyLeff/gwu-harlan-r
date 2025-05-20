############################################################################
##  imaginaryPhyloTools.R   (teaching edition, 2025-05-20)
############################################################################
if (
  !requireNamespace("ape", quietly = TRUE) ||
    !requireNamespace("phytools", quietly = TRUE)
)
  stop("Packages 'ape' and 'phytools' are required.")

library(ape)
library(phytools)
library(ggplot2)
library(viridisLite)

############################  HIDDEN UTILITIES  ############################
# Opaque class id:   0 → high λ , 1 → mid λ , 2 → low λ
.class_id <- function(id) {
  # cheap hash: 3 least-sig bits of a linear-congruential transform
  ((id * 2654435761) %% 2^32) %% 3
}

# Instructor key: exact λ that should be recovered
.expected_lambda <- function(id, lam_mid = 0.5) {
  c(1, lam_mid, 0)[.class_id(id) + 1]
}

############################  PUBLIC  API  #################################
#' Generate a deterministic teaching tree and a single trait
#'
#' Creates a random bifurcating phylogeny whose topology and branch
#' lengths are reproducible from the integer \code{id}, then simulates
#' **one** continuous trait under a pre-assigned phylogenetic-signal
#' class:
#' * **High**  (\eqn{\lambda\approx1})  – Brownian motion on the unscaled tree.
#' * **Mid**   (\eqn{\lambda\approx lam\_mid}) – Brownian motion on a
#'   tree whose internal branches are multiplied by \code{lam_mid}.
#' * **Low**   (\eqn{\lambda\approx0}) – i.i.d. white noise (no
#'   phylogenetic signal).
#' The class is determined by a hidden hash of \code{id}, so students
#' cannot simply take \code{id \% 3}.
#'
#' @param id        Integer.  Determines both the tree topology and the
#'                  hidden phylogenetic-signal class.
#' @param n_species Number of tips to simulate.  Default \code{50}.
#' @param lam_mid   Numeric \eqn{(0<\lambda<1)} used for the
#'                  intermediate-signal class.  Default \code{0.5}.
#'
#' @return A list with components
#'   \describe{
#'     \item{\code{tree}}{An object of class \code{phylo}.}
#'     \item{\code{trait}}{Named numeric vector of length
#'       \code{n_species}.}
#'   }
#' @examples
#' dat <- generate_tree(id = 17, n_species = 60)
#' str(dat)
#' @export
generate_tree <- function(id, n_species = 50, lam_mid = 0.5) {
  set.seed(id) # reproducible topology
  tip.names <- generate_species_names(n_species) # <- NEW
  tree <- rtree(n_species, tip.label = tip.names)

  cls <- .class_id(id)
  if (cls == 0) {
    # HIGH signal (λ≈1)
    trait <- fastBM(tree)
  } else if (cls == 1) {
    # MID signal (λ≈lam_mid)
    trait <- fastBM(phytools:::lambdaTree(tree, lam_mid))
  } else {
    # LOW signal (white noise)
    trait <- rnorm(n_species)
  }

  names(trait) <- tip.names

  list(tree = tree, trait = trait, trait_name = generate_trait_name(), id = id)
}

#' Plot a phylogeny with a continuous trait using \pkg{ggtree}
#'
#' Produces a colour-gradient tree plot with 45-degree tip labels and a
#' single Viridis colour bar below the figure.  **No value of
#' \eqn{\lambda} is shown in the title** so students must estimate it
#' themselves.
#'
#' @param tree        A \code{phylo} object.
#' @param trait       Named numeric vector; names must match the tip
#'                    labels in \code{tree}.
#' @param trait_name  A character value (string).
#' @param id          Put Model ID as a string here for plotting. Defaults to "NO NAME".
#' @param label_angle Rotation angle for tip labels (degrees).
#'                    Default \code{45}.
#' @param label_size  Font size for tip labels.  Default \code{3}.
#'
#' @return A \code{ggplot} object (class \code{gg} / \code{ggtree}).
#' @examples
#' dat <- generate_tree(3)
#' p <- plot_tree(dat$tree, dat$trait)
#' p
#' @export
plot_tree <- function(
  tree,
  trait,
  trait_name,
  id = "NO NAME",
  label_angle = 0,
  label_size = 3
) {
  if (
    !requireNamespace("ggtree", quietly = TRUE) ||
      !requireNamespace("viridisLite", quietly = TRUE)
  )
    stop("Need packages 'ggtree' and 'viridisLite' to plot.")

  library(ggtree)
  library(viridisLite)

  ggtree(tree, aes(color = trait), size = 0.8) %<+%
    data.frame(label = names(trait), trait = trait) +
    geom_tiplab(
      angle = label_angle,
      hjust = 0,
      size = label_size,
      offset = 0.02 * max(nodeHeights(tree))
    ) +
    scale_color_viridis_c(name = trait_name) +
    theme_tree2() +
    theme(legend.position = "bottom") +
    ggtitle(paste("Phylogenetic Tree For Lineage #", id, sep = ""))
}

#' Maximum-likelihood Pagel \eqn{\lambda} and LR P-value
#'
#' Convenience wrapper around \code{phytools::phylosig()} that extracts
#' just the two headline statistics needed for the assignment.
#'
#' @param tree  A \code{phylo} object (unscaled).
#' @param trait Named numeric vector; names must match \code{tree$tip.label}.
#'
#' @return A list with two elements
#'   \describe{
#'     \item{\code{lambda_ML}}{Maximum-likelihood estimate of
#'       Pagel \eqn{\lambda}.}
#'     \item{\code{p_value}}{Likelihood-ratio test P-value for
#'       \eqn{H_0:\lambda = 0}.}
#'   }
#' @examples
#' dat <- generate_tree(42, n_species = 80)
#' get_stats(dat$tree, dat$trait)
#' @export
get_stats <- function(tree, trait) {
  fit <- phylosig(tree, trait, method = "lambda", test = TRUE)
  list(lambda_ML = fit$lambda, p_value = fit$P)
}

############################################################################
#' Generate whimsical species names
#'
#' Creates \code{n} unique character strings by randomly pairing
#' predefined prefixes and suffixes, then appending a running index.
#' The random seed is *not* set inside the function; callers who need
#' reproducibility should call \code{set.seed()} beforehand.
#'
#' @param n          Integer: number of names to return.
#' @param prefixes   Character vector of syllable prefixes.  Default
#'                   set contains onomatopoeic alien sounds.
#' @param suffixes   Character vector of syllable suffixes.
#'
#' @return A character vector of length \code{n} with no duplicated
#'         entries.
#' @examples
#' set.seed(1); generate_species_names(3)
#' @export
generate_species_names <- function(
  n,
  prefixes = c("Glim", "Snarp", "Woot", "Zorp", "Floo", "Gibble"),
  suffixes = c("lefoot", "wing", "snout", "bert", "zoot", "skib")
) {
  make.unique(
    sprintf(
      "%s%s%d",
      sample(prefixes, n, TRUE),
      sample(suffixes, n, TRUE),
      seq_len(n)
    )
  )
}

############################################################################
#' Pick a whimsical trait name
#'
#' Returns one random label from a fixed pool of light-hearted trait
#' descriptions.  Intended purely for flavour; the chosen name has no
#' impact on downstream calculations.
#'
#' @return A length-1 character vector.
#' @examples
#' set.seed(2); generate_trait_name()
#' @export
generate_trait_name <- function() {
  sample(
    c(
      "Rizz_Frequency_Hz",
      "Simp_Devotion_Scale",
      "Aura_Intensity_Lumens",
      "Vibe_Wavelength_m",
      "Keryn_Loyalty_mg"
    ),
    1
  )
}
