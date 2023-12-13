# Code for scraping and cleaning for the World_Cup data

url = "https://en.wikipedia.org/wiki/FIFA_World_Cup"
page <- read_html(url)
Fifa <- page %>%
  html_nodes('table')%>%
  .[[4]] %>%
  html_table(header=FALSE, fill=TRUE)

World_Cup <- Fifa %>%
  magrittr::set_colnames(c('Year','Hosts','Venues',
                           'Totalattendance','Matches',
                           'Averageattendance') ) %>%
  select(1:6) %>%
  slice(-1 *1:2)

World_Cup <- World_Cup[, c('Year','Hosts', 'Matches',
                           'Totalattendance', 'Averageattendance')] %>%
  mutate( Totalattendance = str_remove_all(Totalattendance, pattern = '(\\,)')) %>%
  mutate( Averageattendance = str_remove_all(Averageattendance, pattern = '(\\,)')) %>%
  mutate(Matches = as.numeric(Matches)) %>%
  mutate(Totalattendance = as.numeric(Totalattendance)) %>%
  mutate(Averageattendance = as.numeric(Averageattendance)) %>%
  drop_na() %>%
  data.frame()

World_Cup <- head(World_Cup , -1)

# Save the data frame to the data/ directory as  World_Cup.rda
usethis::use_data(World_Cup, overwrite=TRUE)
