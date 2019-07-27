rm(list = ls())

# Setting working directory
getwd()
setwd("E:/R-Advanced")
getwd()

# Loading the dataset

fin <- read.csv("P3-Future-500-The-Dataset.csv", na.strings = c(""))
str(fin)
head(fin)

# Converting data to correct data types
fin$ID <- factor(fin$ID)
fin$Inception <- factor(fin$Inception)

fin$Growth <- as.numeric(gsub("%", "", fin$Growth))
fin$Expenses <- as.numeric(gsub(",","", gsub(" Dollars", "", fin$Expenses)))
fin$Revenue <- as.numeric(gsub("\\$", "", gsub(",", "", fin$Revenue)))

# Dealing with Missing Data

fin[!complete.cases(fin),]

# Removing rows with missing Industry

fin <- fin[!is.na(fin$Industry),]

# Replacing Missing Data: Factual Analysis Method

fin[is.na(fin$State) & fin$City == "New York", "State"] <- "NY" 
fin[is.na(fin$State) & fin$City == "San Francisco", "State"] <- "CA" 


# Replacing Missing Data: Median Imputation Method

med_emp_retail <- median(fin[fin$Industry == "Retail", "Employees"], na.rm = TRUE)
med_emp_retail

fin[is.na(fin$Employees) & fin$Industry == "Retail", "Employees"] <- med_emp_retail

med_emp_finsrv <- median(fin[fin$Industry == "Financial Services", "Employees"], na.rm = TRUE)
med_emp_finsrv

fin[is.na(fin$Employees) & fin$Industry == "Financial Services", "Employees"] <- med_emp_finsrv


med_growth_cons <- median(fin[fin$Industry == "Construction", "Growth"], na.rm = TRUE)
med_growth_cons

fin[is.na(fin$Growth) & fin$Industry == "Construction", "Growth"] <- med_growth_cons


med_rev_cons <- median(fin[fin$Industry == "Construction", "Revenue"], na.rm = TRUE)

fin[is.na(fin$Revenue) & fin$Industry == "Construction", "Revenue"] <- med_rev_cons


med_exp_cons <- median(fin[fin$Industry == "Construction", "Expenses"], na.rm = TRUE)

fin[is.na(fin$Expenses) & fin$Industry == "Construction", "Expenses"] <- med_exp_cons


# Replacing Missing Values: deriving Value
fin[is.na(fin$Profit), "Profit"] <- fin[is.na(fin$Profit), "Revenue"] - fin[is.na(fin$Profit), "Expenses"]
fin[is.na(fin$Expenses), "Expenses"] <- fin[is.na(fin$Expenses), "Revenue"] - fin[is.na(fin$Expenses), "Profit"]

# Check missing values

fin[!complete.cases(fin),]


# Visulaisations
library(ggplot2)

# Scatterplot clasified by industry showing revenue, expenses & profit

p <- ggplot(data = fin)

p + geom_point(aes(x = Revenue, y = Expenses,
                   colour = Industry, size = Profit))

# Scatterplot that includes industry trends for expenses

d <- ggplot(data = fin, aes(x = Revenue, y = Expenses,
                            colour = Industry))

d + geom_point() +
  geom_smooth(fill=NA, size = 1.2)


# Boxplot
d <- ggplot(data = fin, aes(x = Industry, y = Growth,
                            colour = Industry))

d + geom_jitter() +
  geom_boxplot(size = 1, alpha = 0.5, outlier.colour = NA)

