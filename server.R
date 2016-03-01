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