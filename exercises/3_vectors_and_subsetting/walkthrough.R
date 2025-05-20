# 3_vectors_and_subsetting/walkthrough.R ----------------------------------
# Purpose : Detailed sub-setting (positional, negative, logical, name-based)
#           and the vector recycling rule.
# Usage   : Run line-by-line with Ctrl/Cmd + Enter, or source() the script.

## 0. Creating some working vectors ---------------------------------------

v  <- 10:15                         # simple integer sequence
w  <- seq(1, 3, by = 0.5)           # decimal sequence
nv <- setNames(c(2.2, 3.3, 5.5),    # named numeric vector
               c("alpha", "beta", "gamma"))

## 1. Positional indexing --------------------------------------------------

v[1]           # first element
v[c(2, 4, 6)]  # selected positions
v[2:5]         # contiguous slice

## 2. Negative indexing (drop elements) -----------------------------------
# A negative index means “everything *except* …”  :contentReference[oaicite:1]{index=1}
v[-1]          # drop first element
v[-c(1, 3)]    # drop positions 1 and 3

## 3. Logical indexing -----------------------------------------------------
mask <- v %% 2 == 0   # TRUE for even numbers
v[mask]               # keeps only even values  :contentReference[oaicite:2]{index=2}

## 4. Name-based indexing --------------------------------------------------

nv["beta"]            # single name
nv[c("gamma", "alpha")]

## 5. Recycling rule in arithmetic ----------------------------------------
# Short vector repeats to match the longer one.  :contentReference[oaicite:3]{index=3}
v + 1                 # scalar-as-vector length-1
v + c(1, 2)           # shorter vector recycled
v + c(1, 2, 3)        # length not multiple → warning

## 6. Combining sub-setting & assignment ----------------------------------

v[v %% 2 == 1] <- NA  # set odd positions to NA
v                     # inspect result

# End of walkthrough ------------------------------------------------------
