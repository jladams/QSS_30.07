
source("./R/loading.R")

library(RColorBrewer)
library(plotly)
library(gganimate)
library(scatterplot3d)
library(animation)

color <- grDevices::colors()[grep('gr(a|e)y', grDevices::colors(), invert = T)]

color <- RColorBrewer::brewer.pal()

pigeoncolors <- data_frame(pigeoncolor = sample(color, 13)) %>%
  mutate(pigeon = unique(df$pigeon))

ff2 <- df %>%
  filter(flight == "ff2") %>%
  left_join(pigeoncolors) %>%
  arrange(time)

ggplot(ff2, aes(x = x, y = y, color = pigeon)) +
  geom_path() +
  coord_fixed(ratio = 1)


plot_ly(ff2, x = ~x, y = ~y, z = ~z, type = "scatter3d", mode = "lines",
             color = ~pigeon, colors = ~pigeoncolor)

scatterplot3d(ff2$x, ff2$y, ff2$z, pch = 8)

ggplot(ff1_a, aes(x = x, y = y, size = z)) +
  geom_point()

saveVideo({
  for(i in unique(ff2$time)[1:1000]){
    print(
      ggplot(data = subset(ff2, (time <= i)), aes(x = x, y = y, color = pigeon)) +
        geom_point(data = subset(ff1, (time == i))) +
        geom_path() +
        coord_fixed(ratio = 1)
    )
  }
}, interval = .1, video.name = "ff2_1000.mp4")


saveVideo({
  for(i in 1:100){
    scatterplot3d(ff2$x[i], ff2$y[i], ff2$z[i], pch = 8)
  }
}, interval = .1)




saveVideo({
  for(i in unique(ff1$time)[1:1000]){
    scatterplot3d(
      subset(ff1, (time <= i & time >= i-1000))$x, 
      subset(ff1, (time <= i & time >= i-1000))$y, 
      subset(ff1, (time <= i & time >= i-1000))$z, 
      color = subset(ff1, (time <= i & time >= i-1000))$pigeoncolor, 
      xlim = c(2903, 3130),
      ylim = c(1723, 1959),
      zlim = c(60, 145),
      pch = 8, 
      type = "h"
    )
  }
}, interval = .1)


ff1 <- df %>%
  filter(flight == "ff1") %>%
  left_join(pigeoncolors) %>%
  arrange(time)

ff3 <- df %>%
  filter(flight == "ff3") %>%
  left_join(pigeoncolors)

hf1 <- df %>%
  filter(flight == "hf1") %>%
  left_join(pigeoncolors)


ggplot(ff3, aes(x = x, y = y, color = pigeon)) +
  geom_path() +
  coord_fixed(ratio = 1)

ggplot(hf1, aes(x = x, y = y, color = pigeon)) +
  geom_path() +
  coord_fixed(ratio = 1)




