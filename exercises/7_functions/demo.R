# 7_functions/demo.R ------------------------------------------------------

hello <- function(name) paste0("Hello, ", name, "!")
hello("Riley")

greet <- function(name, punctuation = "!") paste0("Hi, ", name, punctuation)
greet("Juan"); greet("Jane", "!?")

adder  <- function(a, b) a + b
adder_explicit <- function(a, b) { result <- a + b; return(result) }

stats_two <- function(x) list(sum = sum(x), mean = mean(x), n = length(x))
stats_two(1:10)

summarise_print <- function(x, ...) print(summary(x, ...))
summarise_print(rnorm(100), digits = 3)

sapply(1:5, function(z) z^2)

make_counter <- function() { i <- 0; function() { i <<- i + 1; i } }
counter <- make_counter(); counter(); counter()
