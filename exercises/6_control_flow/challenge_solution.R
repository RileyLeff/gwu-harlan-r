# 6_control_flow/challenge_solution.R ------------------------------------

## 1
classify <- function(num) {
  if (num < 0) {
    "low"
  } else if (num < 10) {
    "mid"
  } else {
    "high"
  }
}

## 2
vec <- c(-2, 0, 5, 12)
labels <- ifelse(vec < 0, "low",
                 ifelse(vec < 10, "mid", "high"))
print(labels)

## 3
x <- 1:5
run_mean <- numeric(length(x))
cum_sum  <- 0
for (i in seq_along(x)) {
  cum_sum      <- cum_sum + x[i]
  run_mean[i]  <- cum_sum / i
}
print(run_mean)   # 1 1.5 2 2.5 3
