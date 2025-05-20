# 1_hello_world/walkthrough.R --------------------------------------------
# Purpose : Introduce the console, comments, basic arithmetic, assignment,
#           and the difference between line-by-line execution and sourcing
#           an entire script.
# Usage   : Place the cursor on any line and press Ctrl/Cmd + Enter, or
#           run source("walkthrough.R") to execute the whole file.

## 0. Printing a message ---------------------------------------------------

print("Hello, world")

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
