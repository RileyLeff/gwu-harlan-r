source("util/imaginaryPhyloTools.R")

library(phytools)

data <- generate_tree(id = 20, n_species = 500)

plot_tree(data$tree, data$trait, data$trait_name)

st <- get_stats(data$tree, data$trait)
st$lambda_ML # estimated λ̂
st$p_value # test of λ > 0
