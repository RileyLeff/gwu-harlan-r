# 7_functions/walkthrough.R ----------------------------------------------
# Purpose : Define, call, and document functions in base R.
#           Topics: arguments, defaults, return(), multiple outputs,
#                   the ... ellipsis, anonymous & higher-order functions,
#                   lexical scoping, and pure-function best practices.
# Usage   : Run line-by-line (Ctrl/Cmd + Enter) or source() the script.

## 0. Defining and calling -------------------------------------------------

hello <- function(name) {
  paste0("Hello, ", name, "!")
}
hello("Riley")

## 1. Default arguments ----------------------------------------------------

greet <- function(name, punctuation = "!") {
  paste0("Hi, ", name, punctuation)
}
greet("Juan")          # uses default
greet("Jane", "!?")    # override

## 2. Explicit vs. implicit return ----------------------------------------

adder <- function(a, b) {
  a + b                # last expression returned implicitly
}
adder(3, 4)

adder_explicit <- function(a, b) {
  result <- a + b
  return(result)       # explicit return
}

## 3. Multiple outputs via list -------------------------------------------

stats_two <- function(x) {
  list(
    sum  = sum(x),
    mean = mean(x),
    n    = length(x)
  )
}
stats_two(1:10)$mean

## 4. Ellipsis (...) for pass-through args --------------------------------

summarise_print <- function(x, ...) {
  print(summary(x, ...))  # ... forwarded to summary()
}
summarise_print(rnorm(100), digits = 3)

## 5. Anonymous & higher-order functions ----------------------------------

sapply(1:5, function(z) z^2)     # square each element

## 6. Lexical scoping ------------------------------------------------------

make_counter <- function() {
  i <- 0
  function() {
    i <<- i + 1      # modifies outer variable
    i
  }
}
counter <- make_counter()
counter(); counter()

## 7. Pure-function guideline ---------------------------------------------
# Prefer “pure” functions whenever possible:
#   • Output depends only on inputs.
#   • No modification of objects outside the function (no global <<-, assign()).
#   • No hidden I/O (printing, writing files) unless that *is* the function’s job.
#
# Pure functions are easier to test, reuse, and parallelise.
# If you must cause side-effects (e.g. logging, progress bars), keep them small
# and clearly documented.

# End of walkthrough ------------------------------------------------------
