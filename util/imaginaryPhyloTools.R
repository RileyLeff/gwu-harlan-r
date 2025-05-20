# imaginaryPhyloTools.R

# Load necessary libraries that your functions will use
# It's good practice to check if they are installed first
if (!requireNamespace("ape", quietly = TRUE)) install.packages("ape")
if (!requireNamespace("phytools", quietly = TRUE)) install.packages("phytools")
library(ape)
library(phytools)

generate_creature_lambda_data <- function(student_unique_value, num_creatures = 20) {
  set.seed(student_unique_value)

  # --- Determine the "True" target_lambda_value ---
  # Example: (student_unique_value %% 11) / 10  gives 0.0, 0.1, ..., 1.0
  target_lambda_value <- round(((student_unique_value %% 101) / 100), 2) # 0.00 to 1.00 for more granularity

  # --- Generate Silly Names ---
  # (Keep your name generation logic here)
  silly_prefixes <- c("Glim", "Snarp", "Woot", "Zorp", "Floo", "Gibble")
  silly_suffixes <- c("lefoot", "wing", "snout", "bert", "zoot", "skib")
  creature_names <- character(num_creatures)
  for (i in 1:num_creatures) {
    creature_names[i] <- paste0(sample(silly_prefixes, 1),
                                sample(silly_suffixes, 1),
                                i) # Add number for uniqueness
  }
  creature_names <- make.unique(creature_names)


  # --- Generate a Base Phylogenetic Tree ---
  base_tree <- ape::rtree(n = num_creatures, tip.label = creature_names)
  base_tree <- ape::compute.brlen(base_tree, method = "Grafen", power = 0.5) # Make branches a bit more even looking

  # --- Generate a Continuous Trait with Known Lambda ---
  # Ensure target_lambda_value is within phytools' expectations (0 to 1 usually)
  target_lambda_value <- max(0, min(1, target_lambda_value))

  transformed_tree <- phytools:::lambdaTree(base_tree, lambda = target_lambda_value)
  # Simulate with some variance to ensure non-zero trait values
  trait_values <- phytools::fastBM(transformed_tree, sig2 = runif(1, 0.5, 2.0), a = runif(1, -1, 1)) # a is root state, sig2 is rate

  # Give the trait a silly continuous name
  silly_trait_names <- c("Rizz_Frequency_Hz", "Simp_Devotion_Scale_Dimensionless", "Aura_Intensity_Lumens", "Vibe_Wavelength_Meters", "Keryn_Loyalty_Milligrams")
  trait_name <- sample(silly_trait_names, 1)

  return(
    list(
      student_id = student_unique_value,
      base_tree = base_tree,
      trait_name = trait_name,
      trait_data = trait_values,
      true_target_lambda = target_lambda_value
    )
  )
}

# You could add other helper functions here if needed.
cat("Helper functions from 'imaginaryPhyloTools.R' loaded.\n")