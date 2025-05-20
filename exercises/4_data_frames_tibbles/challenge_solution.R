# 4_data_frames/challenge_solution.R -------------------------------------

## 1
cars <- data.frame(
  speed = c(60, 72, 85, 90),
  time  = c(1.0, 0.8, 0.7, 0.6)
)
cars$distance <- cars$speed * cars$time

## 2
row2_distance <- cars[2, "distance"]

## 3
cars[cars$distance < 60, "distance"] <- NA

## 4
cars <- cars[ , -which(names(cars) == "time")]  # or cars$time <- NULL

print(row2_distance)
print(cars)
