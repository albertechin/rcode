rm(list=ls())

# Reading data from csv file
stats <- read.csv("P2-Demographic-Data.csv")

#Checking dataframe
str(stats)
summary(stats)
head(stats)

# Plot graph
# produce a scatterplot illustrating Birth Rate and Internet Usagestatistics by Country.
# The scatterplot needs to also be categorised by Countries' Income Groups.
library("ggplot2")
qplot(data=stats, x=Birth.rate, y=Internet.users, size=I(3), shape=I(19), alpha=I(0.6),
      colour=Income.Group)


      
      