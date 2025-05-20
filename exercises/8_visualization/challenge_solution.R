# 8_visualization/challenge_solution.R -----------------------------------

## 1
data(mtcars)                    # built-in
pdf_path <- "output/mtcars_plots.pdf"
dir.create("output", showWarnings = FALSE)

## 2 & 3
pdf(png_path, width = 8, height = 4)
par(mfrow = c(1, 2))
plot(mtcars$wt, mtcars$mpg,
     main = "mpg vs wt",
     xlab = "Weight (1000 lbs)", ylab = "Miles/gallon",
     pch = 19, col = "tomato")
hist(mtcars$hp,
     main = "Horsepower",
     xlab = "hp", breaks = 15, col = "gray")
dev.off()

cat("Plots saved to", png_path, "\n")
