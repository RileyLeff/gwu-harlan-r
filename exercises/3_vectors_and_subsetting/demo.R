# 3_vectors_and_subsetting/demo.R ----------------------------------------

v  <- 10:15
w  <- seq(1, 3, by = 0.5)
nv <- setNames(c(2.2, 3.3, 5.5), c("alpha", "beta", "gamma"))

v[1]
v[c(2, 4, 6)]
v[2:5]

v[-1]
v[-c(1, 3)]

mask <- v %% 2 == 0
v[mask]

nv["beta"]
nv[c("gamma", "alpha")]

v + 1
v + c(1, 2)
v + c(1, 2, 3)

v[v %% 2 == 1] <- NA
v
