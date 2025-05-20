# 1_hello_world/walkthrough.R --------------------------------------------
# Purpose : Introduce the console, comments, basic arithmetic, assignment,
#           and the difference between line-by-line execution and sourcing
#           an entire script.
# Usage   : Place the cursor on any line and press Ctrl/Cmd + Enter, or
#           run source("walkthrough.R") to execute the whole file.

## 0. Printing a message ---------------------------------------------------

print("Hello, world")

## 0.1 Installing and loading a package
# install.packages("palmerpenguins")   # run once, downloads from CRAN
# install.packages("cowsay")           # most important package you will ever install
library(palmerpenguins)                # make functions/data available
data(package = "palmerpenguins")       # list objects in the package

# you can also access functions in a package without using library() to load the whole package
# this is nice because you can see exactly where the function came from
# and sometimes if you load a whole package it loads a ton of stuff that you don't need/want
cowsay::say("wassup")
cowsay::say("ain't that some shit", "chicken")

## 0.2 Finding documentation  ----
?mean                 # open help for a specific function
??as_factor           # full-text search across installed help
help.search("factor") # alias for ??

## 1. Simple arithmetic ----------------------------------------------------

2 + 2          # addition
7 * 6          # multiplication
sqrt(49)       # built-in function

## 2. Object assignment ----------------------------------------------------

x <- 10        # create an object called x
y <- x^2 + 5   # use x in an expression
print(y)       # explicit printing inside a script

## 3. Inspecting objects ---------------------------------------------------

str(x)         # compact structure display
str(y)

## 4. Running the entire script -------------------------------------------

# Uncomment the next line to run everything in this file at once
# source("walkthrough.R")
