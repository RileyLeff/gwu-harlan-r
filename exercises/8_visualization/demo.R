# 8_visualization/demo.R --------------------------------------------------

set.seed(42)
v  <- rnorm(50)
df <- data.frame(
  x = rnorm(50),
  y = rnorm(50),
  grp = sample(c("A", "B"), 50, replace = TRUE)
)

plot(df$x, df$y, main = "Scatter", xlab = "x", ylab = "y", pch = 19)
hist(v, main = "Histogram of v", xlab = "value")
boxplot(y ~ grp, data = df, main = "y by group")

par(mfrow = c(2, 2))
plot(df$x, type = "l", main = "Line")
hist(v, main = "Hist again")
boxplot(v, main = "Box")
plot(cumsum(v), type = "l", main = "Cumsum")
par(mfrow = c(1, 1))

png("output/scatter_hist.png", 800, 400)
par(mfrow = c(1, 2))
plot(df$x, df$y, main = "Scatter")
hist(v, main = "Hist")
dev.off()
