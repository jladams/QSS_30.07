
# Getting started
new_int <- 4 # 'new_int' is a name we made up - variables can be called whatever is easy for you to remember
new_int

cos(new_int) # Finds the cosine of the value stored in new_int
cos(4)

# Functions
new_fun <- function(x) { # Creates a function called new_fun that takes one argument, "x"
  my_int <- x # Stores "x" as my_int
  your_int <- my_int * 2 # Stores x * 2 as your_int
  cat("My integer is ",my_int," and your integer is ",your_int) # Prints out a result telling us each our numbers
}

new_fun(4) # Try it out with any number

# For loops and vectors
my_nums <- c(1, 2, 3, 4, 8, 9, 10)

my_nums * 2

for (i in my_nums) {
  print(i * 2)
}


# Working with/plotting data
library(gapminder)
library(tidyverse)

View(gapminder)

# Subsetting Data with dplyr, using the pipe

select()
filter()

# select() and pipe
year_country_gdp <- select(gapminder,year,country,gdpPercap)

year_country_gdp <- gapminder %>% 
  select(year,country,gdpPercap)

# filter()
year_country_gdp_euro <- gapminder %>%
  filter(continent=="Europe") %>%
  select(year,country,gdpPercap)

# Manipulating with tidyr
gap_united <- gapminder %>%
  unite(col = continent_country, continent, country)

gap_separated <- gap_united %>%
  separate(col = continent_country, into = c("continent", "country"), sep = "_")

# Plotting with ggplot


# start by opening one file GRAPHICALLY to get options
ff2_A <- read_delim("~/projects/QSS30.07/data/pigeonflocks_trajectories/ff2/ff2_A.txt", "\t", escape_double = FALSE, trim_ws = TRUE, skip = 18)

# Get a list of all files
files <- list.files("./data/pigeonflocks_trajectories/ff2", pattern = "*.txt", full.names = TRUE)

# Import all files as a list
files_list <- lapply(files, read_delim, "\t", escape_double = FALSE, trim_ws = TRUE, skip = 18)

# Combine all the tables into one with a new column to identify the pigeon. Then keep only pigeon, time, x, y, and z
ff2 <- files_list %>%
  bind_rows(.id = "pigeon") %>%
  select(pigeon, time = `#t(centisec)`, x = `X(m)`, y = `Y(m)`, z = `Z(m)`)

# Plotting pigeons
library(plotly)
library(scatterplot3d)
library(animation)

# Plot pigeons from above using ggplot
ggplot(ff2, aes(x = x, y = y, color = pigeon)) +
  geom_path() +
  coord_fixed(ratio = 1)

# basic 3d scatterplot
scatterplot3d(ff2$x, ff2$y, ff2$z, pch = 8)

# plot in 3d interactive using plotly (first is with height, second with time)
plot_ly(ff2, x = ~x, y = ~y, z = ~z, type = "scatter3d", mode = "lines",
        color = ~pigeon)

plot_ly(ff2, x = ~x, y = ~y, z = ~time, type = "scatter3d", mode = "lines",
        color = ~pigeon)

# Animate some of the frames
saveVideo({
  for(i in unique(ff2$time)[10000:10100]){
    print(
      ggplot(data = subset(ff2, (time <= i & time >= (i-1000))), aes(x = x, y = y, color = pigeon)) +
        geom_point(data = subset(ff1, (time == i))) +
        geom_path() +
        coord_fixed(ratio = 1)
    )
  }
}, interval = .1, video.name = "output/mp4/ff2_workshop.mp4")
