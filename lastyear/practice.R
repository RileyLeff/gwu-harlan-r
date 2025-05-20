############################################################################################

#Part 1: RStudio 101

#Welcome to R Studio!
#this is a script, saved as a .R file. While you can execute commands directly in the
#console below, saving your code as a script allows you to come back to it and see what you
#did at any time

# Annotating code

#Hashtags (#) allow you to make annotations in your .R file. The program will know to ignore
# this text, but these notes will help you later to remember what is happening in your code

#Exercise 1.1:
#Add three lines of notes below, stating what you had for breakfast today, the weather
#outside and your favorite marine organism.

# Executing code

#To run code from your R script, press Ctrl+Enter (command-return for mac) or manually click ->Run in the upper righthand corner of the R script. This executes the line or chunk of code the cursor is on, or any highlighted code.

#Exercise 1.2:
#Solve the following equation by copy/pasting it onto a new line
#w/o a hashtag, and executing the script : 453*4.6/2+34

453 * 4.6 / 2 + 34


#'<-' operator

#The '<-' operator assigns a name to any attribute and is used to store data while you are #working. This can be typed as either '<-' or '->' and the name that is being pointed to will #be assigned what is written on the other side.

#Exercise 1.3: execute the following:

test_score <- 34 / 35 * 100
test_score


#When you've reached this point, save the script as practice_YOURNAME.R, place your "finished" post-it note on your computer, and wait for everyone to finish.

###########################################################################################

#Part II: Inputting and Organizing Data

# Step 1: Set working directory

#To be able to read in data, R needs to know exactly where the data are. By setting your #working directory in the very beginning of a script, you can give R the location to look for #files to read in. It is also the location where R will save files.

#getwd shows you what your current working directory is.
getwd()

#To set your working directory, modify the following code to the appropriate location on your computer where the sample_data.csv file is
#This is an example of formatting with my directories, but yours will have different names

# On mac
setwd("/Users/AndreaLangeland/Desktop/Rfiles")

# On PC
setwd("C:/Users/AndreaLangeland/Desktop/Rfiles")
#Alternatively go to Session -> Set Working directory -> To source file location

getwd()


# Step 2: read in the data
# import the data file to a data frame called data with the read.csv function.
data <- read.csv("sample_data.csv")


#Note: its always preferable to read in data as a .csv (which stands for "comma separated variable") as opposed to a .xlsx, as it is easier for R to read. You can save files as .csv in Excel

#When you've reached this point, place your "finished" post-it note on your computer, and wait for everyone to finish.

############################################################################################

#Part III: Working with data
#First, we'll load in the package "car" which has some functions we'll be working with

#install.packages('car')
#this function installs a package onto your computer. You only need to do this once

library(car)
#this function loads a package into your R session. You need to do this every time you use this package in a new RStudio session.

#Summmary statistics

#Exercise 3.1:

#First let us look at the data, click on 'Data' in the Environment panel. Familiarize yourself with the data

#The following are useful functions for getting a sense of your data. Execute them, then #look at the help documentation for each.
head(data)
?head

summary(data)
?summary

str(data)
?str
#What information did these functions provide?

#Visualizing data

#you should also do some preliminary graphing to get a sense of your data
#simple functions like boxplot() can help out with this

#Exercise 3.2:
#create the following plots (look at the documentation for the functions) and take a look at your data. From these plots, do you think canopy cover and disturbance affect caterpillar density? Does it look like there are any outliers

boxplot(abundance ~ disturbance, data = data)
?boxplot


plot(abundance ~ canopy_cover, data = data)
#This plot can also be plotted using the following function. This time you do not have to type out "data=data" because you are specifying that "canopy_cover" is pulled from "data" using "$".
plot(data$canopy_cover, data$abundance)
?plot


#Statistical Assumptions

#Exercise 3.3
#does our response variable (caterpillar abundance) follow a normal distribution? If you are unsure of how to interpret the result, look at the shapiro.test documentation or online resources

shapiro.test(data$abundance)
?shapiro.test
#note that to just look at the abundance variable, we call our data file with a "$" and then the variable name

# we can also assess normality visually by looking at a Q-Q plot- a scatter that compares #the data to a perfect normal distribution. The scatter should lie as close to the line as #possible with no obvious pattern coming away from the line for the data to be considered
# normally distributed.
qqnorm(data$abundance)
qqline(data$abundance)

?qqline


#Exercise 3.4
#Do our data meet expectations of homogeneity of variance?
data$disturbance <- as.factor(data$disturbance)


leveneTest(data$abundance, group = data$disturbance)
?leveneTest


#When you've reached this point, save the script then place your "finished" post-it note on your computer, and wait for everyone to finish.
###########################################################################################

#Part IV: Statistical analysis
#Exercise 4
#Run the following code to do an ANOVA. Based on the summary of the model, what are our findings?

model1 <- aov(abundance ~ disturbance * canopy_cover, data = data)
summary(model1)


#When you've reached this point, save the script then place your "finished" post-it note on your computer, and wait for everyone to finish.

############################################################################################
#Part V: Graphing

# In part III we did some initial graphing using the boxplot() and plot() functions

boxplot(abundance ~ disturbance, data = data)
?boxplot


plot(data$canopy_cover, data$abundance)
?plot


#now we'll be working with ggplot2 to make more customizable figures. We'll start by installing and loading ggplot2
install.packages('ggplot2')
library(ggplot2)

#Exercise 5.1:
#Here are the two plots I demonstrated in the powerpoint. Execute the code for them and make #sure it works, and that you understand how each component in the function is contributing to the graph output

#version 1
ggplot(data, aes(x = canopy_cover, y = abundance)) +
  geom_point()


#version 2
ggplot(data, aes(x = canopy_cover, y = abundance, color = disturbance)) +
  geom_point()

#Exercise 5.2:
#Attempt to re-create the figure on the powerpoint using a modified version of the function we've been using.

#HINT: you'll need the following elements:
#functions:levels()
#ggplot elements:geom_smooth(),labs(),scale_color_manual(),theme_minimal()

#Use this guide to help http://www.sthda.com/english/wiki/ggplot2-scatter-plots-quick-start-guide-r-software-and-data-visualization
