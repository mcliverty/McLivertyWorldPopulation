#code for cleaning the "WorldPopulation.xlsx" file

library(tidyverse)
library(readxl)

worldpop <- read_excel("data-raw/WorldPopulation.xlsx",
                       sheet='ESTIMATES' , range='A17:BZ306')

WorldPopulation <- data.frame(worldpop) %>%
  filter(worldpop$Type == 'Country/Area' )

colnames(WorldPopulation)[3] <- 'Country Name'

WorldPopulation <- WorldPopulation %>%
  select( 'Country Name' | starts_with('X') )

#Changing the column names

name <- c('Country Name', seq(1950,2020))

colnames(WorldPopulation)[] <- name


# Save the data frame to the data/ directory as WorldPopulation.rda
usethis::use_data(WorldPopulation, overwrite=TRUE)
