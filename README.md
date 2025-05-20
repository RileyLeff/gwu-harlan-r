# Introduction to R for Undergraduate Biology Students 📊🧬

Welcome! This repository contains materials for an introductory R workshop tailored for undergraduate biology students. The workshop aims to equip students with fundamental R programming skills applicable to biological data analysis.

---
## Repository Structure

* **`data/`**: Contains sample datasets used in exercises and demonstrations.
    * `chillin.csv`: A sample CSV file for data import/export exercises.
* **`exercises/`**: The core of the workshop, organized into thematic modules. Each module typically includes:
    * `demo.R`: R script demonstrating concepts.
    * `walkthrough.R`: A detailed, commented script for step-by-step learning.
    * `challenge.R`: Exercises for students to practice.
    * `challenge_solution.R`: Solutions to the challenges.
    * Modules cover topics from basic R syntax and data types to data manipulation, control flow, functions, and basic data visualization.
    * `0_rileys_rant_about_setwd/`: Guidance on managing working directories effectively.
    * `9_final_challenge/`: Capstone exercises integrating multiple concepts.
* **`util/`**: Contains utility scripts with helper functions used in the exercises, particularly for the final challenges involving phylogenetic data.
    * `riley_phylo_tools.R`: Custom functions for generating and analyzing phylogenetic tree data for more advanced examples.

---
## Workshop Content Overview

The workshop progresses through the following key R programming concepts:

1.  **Hello World**: Basic R syntax, console interaction, and script execution.
2.  **Data Types**: Understanding atomic vector types (numeric, character, logical), `NA`, `NULL`, and factors.
3.  **Vectors and Subsetting**: Creating, manipulating, and subsetting vectors using various indexing methods.
4.  **Data Frames & Tibbles**: Working with tabular data structures.
5.  **Read/Write Data**: Importing data from CSV files and exporting results.
6.  **Control Flow**: Using conditional statements (`if`/`else`) and loops (`for`, `while`).
7.  **Functions**: Writing and using custom R functions.
8.  **Visualization**: Creating basic plots with base R.
9.  **Final Challenge**: Applying learned skills to more complex, biology-themed problems.

---
## Getting Started

1.  Clone or download this repository.
2.  Open the R scripts within each exercise folder (e.g., in RStudio).
3.  Follow the `walkthrough.R` files for guided learning.
4.  Attempt the `challenge.R` files to practice the concepts.
5.  Refer to `demo.R` for concise examples and `challenge_solution.R` to check your work.

Happy coding! 🚀