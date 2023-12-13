#' A function for graphing UN countries population from 1950 to 2020
#'
#'
#'
#'
#' @param country a string
#' @return a graph of the specified country's estimated population
#' @examples
#' CountryPopulation('Switzerland')
#' CountryPopulation('New Zealand')
#' @export
#'
#'
#'
CountryPopulation <- function(country){

  country <- as.character(country)

  data(WorldPopulation)

  pivoted <-  data.frame(pivot_longer(WorldPopulation,
                                      '1950':'2020',
                                      names_to = 'Years',
                                      values_to = 'Population'
  )) %>%
    mutate(Population = as.numeric(Population))

  countryrows <- pivoted %>%
    filter(Country.Name == country)

  newgraph <- ggplot(countryrows, aes(x=Years, y=Population)) +
    geom_point()+
    scale_x_discrete( breaks=seq(1930,2020, by=10)) +
    labs(title= paste("Population of ", country, "From 1950 to 2020"),
         x='Years',
         y='Population (in thousands)' )

  newgraph
  }
