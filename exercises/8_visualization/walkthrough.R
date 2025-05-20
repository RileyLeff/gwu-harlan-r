# 8_visualization/walkthrough.R ------------------------------------------
# Purpose : Quick exploratory plots with base R and how to save them.
# Usage   : Run line-by-line (Ctrl/Cmd + Enter) or source() this file.

## 0. Set up a reproducible numeric vector and small data frame -----------

set.seed(42)
v  <- rnorm(50)
df <- data.frame(
  x = rnorm(50),
  y = rnorm(50),
  grp = sample(c("A", "B"), 50, replace = TRUE)
)

## 1. Scatter plot --------------------------------------------------------

plot(df$x, df$y,
     main = "Scatter: x vs y",
     xlab = "x", ylab = "y", pch = 19, col = "steelblue")

## 2. Histogram -----------------------------------------------------------

hist(v,
     main   = "Histogram of v",
     xlab   = "value",
     breaks = "Sturges")   # default method 

## 3. Box-plot by group ---------------------------------------------------

boxplot(y ~ grp, data = df,
        main = "y by group",
        col  = c("#FFC857", "#7DCE94"))

## 4. Multiple plots in one window ---------------------------------------

par(mfrow = c(2, 2))            # 2 rows × 2 cols
plot(df$x, type = "l", main = "Line")
hist(v, main = "Hist again")
boxplot(v, main = "Box")
plot(cumsum(v), type = "l", main = "Cumsum")
par(mfrow = c(1, 1))            # reset

## 5. Export to file ------------------------------------------------------

png("output/scatter_hist.png", width = 800, height = 400)
par(mfrow = c(1, 2))
plot(df$x, df$y, main = "Scatter")
hist(v, main = "Hist")
dev.off()

## 6. Why you might switch to ggplot2 later ------------------------------
# ggplot2 uses aes() mappings to decouple *what* you plot from *how*
# it looks.  The same scatter could be written as:
#   library(ggplot2)
#   ggplot(df, aes(x, y)) + geom_point()
# Try it once you’re comfortable with packages.

# End of walkthrough ------------------------------------------------------
