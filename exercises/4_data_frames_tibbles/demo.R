# 4_data_frames/demo.R ----------------------------------------------------

df <- data.frame(
  model = rownames(mtcars),
  mpg   = mtcars$mpg,
  cyl   = mtcars$cyl
)

df$mpg
df[["cyl"]]
df[ , "model"]

df[1, ]
df[ , 1:2]
df[df$mpg > 25, ]
df[ -c(1:15), ]

df$constant <- 1
df$kpl      <- df$mpg * 0.425144

df[df$model == "Fiat X1-9", "cyl"] <- 4

library(tibble)
tb <- as_tibble(df)
tb$mpg
