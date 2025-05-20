# 2_data_types/walkthrough.R ---------------------------------------------
# Purpose : Atomic vector types, NA vs NaN vs NULL, basic indexing (read & write),
#           and the idea that a “scalar” is just a vector of length 1.
# Usage   : Run line-by-line with Ctrl/Cmd + Enter, or source() the file.

## 0. Creating atomic vectors ---------------------------------------------

num_vec <- c(1.5, 2.0, 3.14)          # double
int_vec <- c(1L, 2L, 3L)              # integer (note the L)
chr_vec <- c("red", "green", "blue")  # character
log_vec <- c(TRUE, FALSE, TRUE)       # logical

## 1. Inspecting structure -------------------------------------------------

typeof(num_vec)    # storage type
class(num_vec)     # S3 class (same here)
length(num_vec)    # number of elements

## 2. Coercion rules -------------------------------------------------------

c(1, "a")                 # numeric + character → character
as.numeric(log_vec)       # TRUE → 1, FALSE → 0
as.character(num_vec)     # numbers → strings

## 3. Missing placeholders -------------------------------------------------
# • NA   : “Not Available”  – unknown / missing value
# • NaN  : “Not a Number”   – undefined numeric result (e.g. 0/0)
# • NULL : length-0 object  – represents “nothing here” (often from empty return)

na_val  <- NA
nan_val <- 0/0            # produces NaN
null_obj <- NULL

is.na(c(na_val, nan_val))     # TRUE for both NA and NaN
is.nan(c(na_val, nan_val))    # TRUE only for NaN
is.null(null_obj)             # TRUE

length(null_obj)              # 0
typeof(null_obj)              # "NULL"

## 4. Everything is a vector ----------------------------------------------
x <- 1           # length-1 numeric vector
length(x)        # 1
x[2]             # index beyond length ⇒ NA  (fills with missing) 

## 5. Indexing — retrieving values ----------------------------------------

num_vec[2]             # single position
num_vec[c(1, 3)]       # multiple positions
num_vec[num_vec > 2]   # logical mask

## 6. Indexing — updating values ------------------------------------------

num_vec[1]  <- 99
num_vec[2:3] <- c(42, 0)
num_vec

## 7. Handling missing values in summaries --------------------------------

vec_with_na <- c(1, NA, 3)
mean(vec_with_na)                # NA
mean(vec_with_na, na.rm = TRUE)  # 2

# End of walkthrough ------------------------------------------------------
