# 7_functions/challenge_solution.R ---------------------------------------

## 1
square <- function(x) x^2

## 2
add_percent <- function(x, pct = 10) {
  x * (1 + pct / 100)
}

## 3
halves <- sapply(1:6, function(z) z / 2)

# quick checks
print(square(4))          # 16
print(add_percent(200))   # 220
print(halves)             # 0.5 1.0 1.5 2.0 2.5 3.0
