library(tidyverse)
library(stringr)

files <- list.files("./data/pigeonflocks_trajectories", pattern = "*.txt", full.names = TRUE, recursive = TRUE)

files_list <- lapply(files, read_delim, "\t", escape_double = FALSE, trim_ws = TRUE, skip = 18)

fnames <- files %>%
  data_frame() %>%
  separate(col = ".", into = c("blank", "data", "pigeonflock", "trajectories", "flight", "flight2", "pigeon", "extension")) %>%
  select(flight, pigeon) %>%
  unite(name, flight, pigeon)

names(files_list) <- fnames$name

df <- files_list %>%
  bind_rows(.id = "flight_pigeon") %>%
  separate(flight_pigeon, into = c("flight", "pigeon")) %>%
  select(flight, pigeon, time = `#t(centisec)`, x = `X(m)`, y = `Y(m)`, z = `Z(m)`)


