ui <- fluidPage(
  library(leaflet),
  
  leafletOutput("mymap"),
  p(),
  textInput("address", "Type your address", value="206 Washington St SW, Atlanta, GA"), 
  actionButton("button", "Show")
)