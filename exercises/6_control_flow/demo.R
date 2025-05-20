# 6_control_flow/demo.R ---------------------------------------------------

x <- 7
if (x %% 2 == 0) {
  cat(x, "is even\n")
} else {
  cat(x, "is odd\n")
}

v <- 1:6
parity <- ifelse(v %% 2 == 0, "even", "odd")

total <- 0
for (i in v) total <- total + i

count <- 1
while (TRUE) {
  if (count > 5) break
  cat("count =", count, "\n")
  count <- count + 1
}

for (n in v) {
  if (n == 4) next
  print(n)
}

ifelse(v <= 3, v^2, v)

running <- numeric(length(v))
running[1] <- v[1]
for (i in 2:length(v)) running[i] <- running[i - 1] + v[i]
