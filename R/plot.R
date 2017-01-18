
source("./R/loading.R")
library(plotly)

ff1 <- df %>%
  filter(flight == "ff1")

ff2 <- df %>%
  filter(flight == "ff2")

ff3 <- df %>%
  filter(flight == "ff3")

hf1 <- df %>%
  filter(flight == "hf1")

ggplot(ff1, aes(x = `X(m)`, y = `Y(m)`, color = pigeon, frame = `#t(centisec)`)) +
  geom_path() +
  coord_fixed(ratio = 1)

ggplot(ff2, aes(x = `X(m)`, y = `Y(m)`, color = pigeon, frame = `#t(centisec)`)) +
  geom_path() +
  coord_fixed(ratio = 1)

ggplot(ff3, aes(x = `X(m)`, y = `Y(m)`, color = pigeon, frame = `#t(centisec)`)) +
  geom_path() +
  coord_fixed(ratio = 1)

ggplot(hf1, aes(x = `X(m)`, y = `Y(m)`, color = pigeon, frame = `#t(centisec)`)) +
  geom_path() +
  coord_fixed(ratio = 1)

plot_ly(ff1, x = ~`X(m)`, y = ~`Y(m)`, z = ~`Z(m)`, type = "scatter3d", mode = "lines",
             color = ~pigeon, colors = c("#7CFC00", "#00BFFF", "#FFB90F", "#EE2C2C", "#BF3EFF", "#228B22", "#27408B", "#000000"))


