rm(list=ls())

# Loading dataset
movies <- read.csv("P2-Movie-Ratings.csv")
head(movies)
colnames(movies)
colnames(movies) <- c("Film", "Genre", "CriticRating", "AudienceRating", "BudgetMillions", "Year")
colnames(movies)
head(movies)

# Analysing dataset
str(movies)
summary(movies)

# Converting Year into a categorical variable
movies$Year <- factor(movies$Year)
head(movies)
str(movies)

#-------------------------Asthetics

library(ggplot2)
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
       colour=Genre, size=BudgetMillions)) +
  geom_point()


# ------------------------Histogram

s <- ggplot(data=movies, aes(x=BudgetMillions))
s + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black")

#-------------------------Density Chart

s + geom_density(aes(fill=Genre), position = "Stack")


#------------------------Statistical Transformation

u <- ggplot(data = movies, aes(x=CriticRating, y=AudienceRating, colour=Genre))

u + geom_point() + geom_smooth(fill = NA)

#------------------------Boxplot

u <- ggplot(data = movies, aes(x = Genre, y = AudienceRaing, colour = Genre))
u + geom_jitter() + geom_boxplot(size=1.2, alpha = 0.5)


#------------------------Facets

w <- ggplot( data=movies, aes(x = CriticRating,y = AudienceRating, colour = Genre))
w + geom_point(aes(size = BudgetMillions)) +
  geom_smooth() +
  facet_grid(Genre~Year) +
  coord_cartesian(ylim = c(0, 100))

#-------------------------Theme

o <- ggplot(data=movies, aes(x = BudgetMillions)) +
  geom_histogram(binwidth = 10, aes(fill = Genre), colour="Black")


o + xlab("Money Axis") +
  ylab("Number of Movies")+
  ggtitle("Movie Budget Distribution") +
  theme( axis.title.x = element_text(colour = "DarkGreen", size = 30),
          axis.title.y = element_text(colour = "Red", size = 30),
          axis.text.x = element_text( size = 20),
          axis.text.y = element_text( size = 20),
         
         legend.title = element_text( size = 30),
         legend.text = element_text( size = 20),
         legend.position = c(1,1),
         legend.justification = c(1,1),
        
        plot.title = element_text(colour = "DarkBlue",
                                  size = 40,
                                  family = "Courier"))
 