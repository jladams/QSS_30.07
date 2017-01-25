
source("./R/loading.R")

library(RColorBrewer)
library(plotly)
library(scatterplot3d)
library(animation)

color <- grDevices::colors()[grep('gr(a|e)y', grDevices::colors(), invert = T)]

pigeoncolors <- data_frame(pigeoncolor = sample(color, 13)) %>%
  mutate(pigeon = unique(df$pigeon))

ff2 <- df %>%
  filter(flight == "ff2") %>%
  left_join(pigeoncolors) %>%
  arrange(time)

ggplot(ff2, aes(x = x, y = y, color = pigeon)) +
  geom_path() +
  coord_fixed(ratio = 1)


plot_ly(ff2, x = ~x, y = ~y, z = ~time, type = "scatter3d", mode = "lines",
             color = ~pigeon, colors = ~pigeoncolor)

scatterplot3d(ff2$x, ff2$y, ff2$z, pch = 8)

saveVideo({
  for(i in unique(ff2$time)[20001:25000]){
    print(
      ggplot(data = subset(ff2, (time <= i & time >= (i-1000))), aes(x = x, y = y, color = pigeon)) +
        geom_point(data = subset(ff1, (time == i))) +
        geom_path() +
        coord_fixed(ratio = 1)
    )
  }
}, interval = .1, video.name = "output/mp4/ff2_timed_5.mp4")


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



