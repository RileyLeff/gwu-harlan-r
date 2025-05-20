# 2_data_types/challenge_solution.R --------------------------------------

## 1
s <- 8
length(s)         # 1
s[3]              # NA (out-of-bounds → NA)

## 2
v <- 1:10
v[c(4, 9)] <- NA
sum(v, na.rm = TRUE)    # 41

## 3
e <- NULL
length(e)               # 0
result <- c(e, 5)
class(result)           # "numeric" (vector of length 1)
