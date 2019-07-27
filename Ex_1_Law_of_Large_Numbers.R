rm(list=ls())
#N <- as.integer(readline(prompt="Enter N: "))
N <- 1000000
normal_dist <- rnorm(N)

count <- 0
for(i in normal_dist){
  if(i >= -1 & i <= 1){
    count <- count + 1
  }
}

# E(x) = 68.2%
ex <- count/N
ex