# 2_data_types/demo.R -----------------------------------------------------

num_vec <- c(1.5, 2.0, 3.14)
int_vec <- c(1L, 2L, 3L)
chr_vec <- c("red", "green", "blue")
log_vec <- c(TRUE, FALSE, TRUE)

typeof(num_vec); class(num_vec); length(num_vec)

c(1, "a")
as.numeric(log_vec)
as.character(num_vec)

na_val  <- NA
nan_val <- 0/0
null_obj <- NULL
is.na(c(na_val, nan_val)); is.nan(c(na_val, nan_val)); is.null(null_obj)
length(null_obj); typeof(null_obj)

x <- 1
length(x); x[2]

num_vec[2]
num_vec[c(1, 3)]
num_vec[num_vec > 2]

num_vec[1] <- 99
num_vec[2:3] <- c(42, 0)
num_vec

vec_with_na <- c(1, NA, 3)
mean(vec_with_na)
mean(vec_with_na, na.rm = TRUE)
