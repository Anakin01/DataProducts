library(shiny)
library(leaflet)
library(DT)

fluidPage(
  
  titlePanel("New York City - 311 -  Requests",
             windowTitle ="New York City - 311 -  Requests" ),
  
  sidebarLayout(
    
    sidebarPanel(
      h3("Slider changes number of Requests"),
      sliderInput(inputId = "myslider", "Number of Requests:",
                  min = 5, max = 50, value = 10, step = 1)
    ), #endsidebarpanel
    
    mainPanel(
      tabsetPanel(
        tabPanel("Map", leafletOutput("mymap"),
                 h4( textOutput("progressText")),
                 h4( textOutput("closedText"))),
        tabPanel("Table",DT::dataTableOutput("mytable")),
        tabPanel("Info",h4("Here you can obtain some information about the Requests"),
                 h4("made to the City of New York"),
                 h4("Moving the slider you can control the requests you can see"),
                 h4("in the Map and in the Table"),
                 h4("you can also see percentage of open and closed requests")         )
        
      )
    )#end mainpanel
  )# end sidebarlayout
)


