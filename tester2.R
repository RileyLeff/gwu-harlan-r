source("util/imaginaryPhyloTools.R")

dat <- generate_creature_lambda_data(10, num_creatures = 25)
p <- plot_creature_trait(
  dat$lambda_tree,
  dat$trait_data,
  dat$trait_name,
  lambda_value = dat$true_target_lambda
)
p
