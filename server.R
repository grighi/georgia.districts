library(shiny)
library(leaflet)
# Adding labels to points requires what is currently the development version of leaflet. To install:
# library(devtools)
# install_github("rstudio/leaflet")
# but today this corrupts the help pages, so return to: install.packages("leaflet")
library(ggmap)
library(sp) # need for over()
library(maptools)

house <- readShapePoly("HOUSE15.shp")

server <- function(input, output, session) {
  
  points <- eventReactive(input$button, {
    geocode(input$address)
  }, ignoreNULL = FALSE)
  
  output$mymap <- renderLeaflet({
    
    pt <- SpatialPoints(points())
    surrounds <- over(pt, house)$ID
    
    leaflet() %>%
      addProviderTiles("Stamen.TonerLite",
                       options = providerTileOptions(noWrap = TRUE)) %>%
      addPolygons(data=house[house$ID==surrounds,], label=as.character(surrounds)) %>% #,                                         labelOptions = inputlabelOptions(noHide = F)) %>%  # static labels don't work yet
      addMarkers(data = points())
    
  })
}