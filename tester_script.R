# tester_script.R

# --- 1. Load the Helper Script ---
# Make sure 'imaginaryPhyloTools.R' is in your R working directory
# or provide the correct path to it.
if (file.exists("util/imaginaryPhyloTools.R")) {
  source("util/imaginaryPhyloTools.R")
  cat("SUCCESS: 'imaginaryPhyloTools.R' sourced successfully.\n\n")
} else {
  stop("ERROR: 'util/imaginaryPhyloTools.R' not found in the working directory. Please check the path.")
}

# --- 2. Set up a Test Student ID ---
# This ID will be used to generate a reproducible dataset.
test_student_id <- 42 # You can change this to test different outputs
cat(paste("Using test_student_id:", test_student_id, "\n\n"))

# --- 3. Generate Creature Data ---
# This calls the main function from your helper script.
cat("Attempting to generate creature data...\n")
test_data <- NULL # Initialize
tryCatch({
  test_data <- generate_creature_lambda_data(student_unique_value = test_student_id,
                                             num_creatures = 10) # Using fewer creatures for a quick test
  cat("SUCCESS: Data generated using generate_creature_lambda_data().\n\n")
}, error = function(e) {
  cat("ERROR: Failed to generate creature data.\n")
  print(e)
  stop("Data generation failed.")
})

# --- 4. Explore the Generated Data Structure ---
cat("--- Exploring the Structure of the Generated Data ---\n")
str(test_data)
cat("\n")

# --- 5. Print Key Information from the Generated Data ---
cat("--- Key Information from the Generated Data ---\n")
if (!is.null(test_data)) {
  cat(paste("Student ID used for generation:", test_data$student_id, "\n"))
  cat(paste("'True' Target Lambda used in simulation:", round(test_data$true_target_lambda, 3), "\n"))
  cat(paste("Generated Trait Name:", test_data$trait_name, "\n"))
  cat(paste("Number of tips in the tree:", length(test_data$base_tree$tip.label), "\n"))
  cat("First 5 tip labels:", paste(head(test_data$base_tree$tip.label, 5), collapse=", "), "\n")
  cat("First 5 trait values:\n")
  print(head(test_data$trait_data, 5))
  cat("\n")
} else {
  cat("Skipping key information printout as data generation failed.\n")
}

# --- 6. How to Print (Visualize) the Phylogenetic Tree ---
# The `ape` package (loaded by phytools, which is loaded in your helper script)
# provides the `plot()` function for `phylo` objects.

cat("--- Printing (Visualizing) the Phylogenetic Tree ---\n")
if (!is.null(test_data) && inherits(test_data$base_tree, "phylo")) {
  cat("To print the tree, R will typically open a new graphics device window.\n")
  cat("If you are in a non-interactive environment (like a script run non-interactively),\n")
  cat("you might not see the plot, or you might need to save it to a file instead (e.g., using pdf(), plot(...), dev.off()).\n\n")

  # Basic plot of the tree:
  tryCatch({
    plot(test_data$base_tree,
         main = paste("Test Creature Phylogeny (ID:", test_data$student_id, ")"),
         cex = 0.8, # Adjust character expansion for tip labels
         no.margin = TRUE)
    axisPhylo() # Adds a scale bar
    title(sub = paste("'True' Lambda:", round(test_data$true_target_lambda, 2)))
    cat("SUCCESS: `plot(tree_object)` command executed. Check for a plot window if in an interactive session.\n")
  }, error = function(e) {
    cat("ERROR plotting the tree:\n")
    print(e)
    cat("Plotting might fail in some non-interactive environments without a graphics device.\n")
  })
  cat("\n")

  # --- 6b. (Optional) More Advanced Plot with phytools: Trait Mapping ---
  # This maps the continuous trait onto the tree using colors.
  # `contMap` can be a bit slow for very large trees or many plots, but fine for a demo.
  cat("--- (Optional) Advanced Plot: Trait Mapping with phytools::contMap ---\n")
  if (length(test_data$trait_data) == length(test_data$base_tree$tip.label)) {
    cat("Attempting to plot trait on tree using contMap (might open a new plot)...\n")
    tryCatch({
      # Ensure trait data names match tip labels if they exist (fastBM should name them)
      # For robustness, explicitly name the vector if it isn't already
      mapped_trait_data <- test_data$trait_data
      if(is.null(names(mapped_trait_data)) && length(mapped_trait_data) == length(test_data$base_tree$tip.label)) {
          names(mapped_trait_data) <- test_data$base_tree$tip.label
      }
      
      # Check again if names are present and match, after potential naming
      if(!is.null(names(mapped_trait_data)) && all(names(mapped_trait_data) %in% test_data$base_tree$tip.label)) {
        # contMap requires phytools to be loaded, which it should be via imaginaryPhyloTools.R
        contMap_object <- contMap(test_data$base_tree, mapped_trait_data, plot = FALSE)
        plot(contMap_object,
             legend = 0.7 * max(nodeHeights(test_data$base_tree)), # Adjust legend position
             fsize = c(0.7, 0.9), # Adjust font sizes
             main = paste("Trait '", test_data$trait_name, "' on Phylogeny (contMap)", sep=""))
        cat("SUCCESS: `phytools::contMap` plot executed.\n")
      } else {
        cat("WARNING: Skipping contMap plot - trait data names might not match tip labels or are missing.\n")
      }
    }, error = function(e) {
      cat("ERROR with contMap plotting:\n")
      print(e)
    })
  } else {
    cat("Skipping contMap: Trait data length does not match number of tips.\n")
  }

} else {
  cat("Skipping tree plotting as tree data is missing or invalid.\n")
}
cat("\n")

cat("--- Tester script finished. ---\n")