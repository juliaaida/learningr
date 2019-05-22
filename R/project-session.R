# Some trials ----------------------------------------------------------------


weight_kilo <- 10
#Comment:Use Alt-Minus(-) to make <-
weight_kilo
#Vectors:character
ab <- c('a','b')
ab
#Nummeric
onetwo <- c(1,2)
#Logic
logi <- c(TRUE,FALSE)
#data frame
head(iris)
colnames(iris)
str(iris)

# Exercice ----------------------------------------------------------------


# Object names

Faux <- FALSE
a <- 9
mean <- function(x) sum(x)


# Spacing
iris[1, 2]
#x[ ,1]
#x[ , 1]
mean(iris$Sepal.Length)

#, na.rm = TRUE)
#mean( x, na.rm = TRUE )
#function (x) {}

function(x) {
}
height <- feet * 12 + inches
mean(iris, na.rm = 10)
sqrt(x ^ 2 + y ^ 2)
df$z
x <- 1:10

# Indenting
if (y < 0 && debug)
  message("Y is negative"
  )

nrow(iris)

x[, 1]


# Function ----------------------------------------------------------------



add_two <- function(x, y) {
  added <- x + y
  return(added)
}
add_two(5, 6)


mult <- function(x, y) {
  print(x)
  result <- x * y
  return(result)
}
mult(5, 5)


# Packages ----------------------------------------------------------------

library(tidyverse)
source(here::here("R/package-loading.R"))


# Save data ---------------------------------------------------------------

write_csv(iris,here::here("data/iris.csv"))
imported_iris <- read_csv(here::here("data/iris.csv"))
glimpse(imported_iris)


