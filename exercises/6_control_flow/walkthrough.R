# 6_control_flow/walkthrough.R -------------------------------------------
# Purpose : Fundamental control-flow tools in base R:
#           if / else, ifelse(), for-loop, while-loop, break / next.
# Usage   : Run line-by-line (Ctrl/Cmd + Enter) or source() the script.

## 0. if / else -----------------------------------------------------------

x <- 7
if (x %% 2 == 0) {
  cat(x, "is even\n")
} else {
  cat(x, "is odd\n")
}

## 1. ifelse() for vectorised tests --------------------------------------

v <- 1:6
parity <- ifelse(v %% 2 == 0, "even", "odd")
parity                     # "odd" "even" ...

## 2. for-loop ------------------------------------------------------------

total <- 0
for (i in v) {
  total <- total + i
}
total                       # 21

## 3. while-loop with break ----------------------------------------------

count <- 1
while (TRUE) {              # infinite until break
  if (count > 5) break
  cat("count =", count, "\n")
  count <- count + 1
}

## 4. next to skip an iteration ------------------------------------------

for (n in v) {
  if (n == 4) next          # skip printing 4
  print(n)
}

## 5. Choosing between ifelse() and a loop -------------------------------

# Vectorised when every element needs the same rule:
ifelse(v <= 3, v^2, v)

# Loop when each step depends on previous state:
running <- numeric(length(v))
running[1] <- v[1]
for (i in 2:length(v)) {
  running[i] <- running[i - 1] + v[i]
}
running

# End of walkthrough -----------------------------------------------------
