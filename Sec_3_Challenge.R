getwd()
setwd("E:/R-Advanced")
getwd()

# Loading the data
df <- read.csv("P3-Machine-Utilization.csv")
str(df)
head(df)

# Handeling Time 
df$PosixTime <- as.POSIXct(df$Timestamp, format = "%d/%m/%Y %H:%M")

# Calculating Utilization
df$Utilization <- 1 - df$Percent.Idle

# Subsetting the data frame - data frame for RL1 machines
df[!complete.cases(df),]
RL1 <- df[df$Machine == "RL1", ]


head(RL1)
# Construcing list
# Machine Name
# Vector (min, mean, max )

util_stats = c(min(RL1$Utilization, na.rm = T),
               mean(RL1$Utilization, na.rm = T),
               max(RL1$Utilization, na.rm = T)
               )

util_under_90 <- as.logical(length(which(RL1$Utilization < 0.90)))

list_rl1 <- list("RL1", util_stats, util_under_90)
list_rl1


list_rl1$UnknownHours <- RL1[is.na(RL1$Utilization), "PosixTime"]

list_rl1$Data <- RL1

str(list_rl1)


# Time-Series Plot

library(ggplot2)

p <- ggplot(data=df)

my_plot <- p + geom_line(aes(x = PosixTime, y = Utilization, color=Machine)) +
  facet_grid(Machine~.) +
  geom_hline(yintercept = 0.90, color="Black", linetype=3)


my_plot

# Adding Plot to list

list_rl1$Plot <- my_plot
list_rl1
