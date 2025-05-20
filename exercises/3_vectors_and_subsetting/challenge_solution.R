# 3_vectors_and_subsetting/challenge_solution.R ---------------------------

## 1
vec <- c(4, 8, 15, 16, 23, 42)
vec_minus3     <- vec[-3]          # a
vec_over_20    <- vec[vec > 20]    # b

## 2
scores <- setNames(c(90, 85, 92), c("A", "B", "C"))
b_score <- scores["B"]

## 3
x <- 1:6
result <- x + c(10, 20)            # warning: length not multiple
# Explanation (comment):
#   The shorter vector is recycled; because 6 is not a multiple of 2,
#   R issues a warning.

print(vec_minus3)
print(vec_over_20)
print(b_score)
print(result)
