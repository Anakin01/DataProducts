library(shiny)
library(leaflet)
library(DT)


function(input, output, session) {
  # load database
  file = "311_Service_Requests_2016_subset.csv"
  dfSR<-read.csv(file,header=TRUE,sep = ",")
  colnames(dfSR)<-make.names(names(dfSR))
  
  
  dat<-reactive({
    long <- dfSR[1:input$myslider,c("Longitude")]
    lat <- dfSR[1:input$myslider,c("Latitude")]
    date <- dfSR[1:input$myslider,c("Created.Date")]
    comp <- dfSR[1:input$myslider,c("Complaint.Type")]
    status <- dfSR[1:input$myslider,c("Status")]
    borough <- dfSR[1:input$myslider,c("Borough")]
    
    data.frame(Date=date, Complaint=comp,Status=status,Borough=borough,latitude = lat, longitude = long)
  })
  
  output$mytable <- DT::renderDataTable(dat(), 
                                        options = list(paging=FALSE, scrollX = TRUE), 
                                        rownames=TRUE, 
                                        filter = "top")
  
  
  output$mymap <- renderLeaflet({
    
    leaflet(data = dat()) %>%
      addProviderTiles("Esri.NatGeoWorldMap",
                       options = providerTileOptions(noWrap = TRUE)) %>%
      addMarkers(~longitude, ~latitude) %>%
      setView(-73.89, 40.86, zoom=10)  # New York City location
  })
  
  output$progressText <- renderText({
    
    paste0("Open Requests :",ceiling(nrow(dat()[dat()$Status=="Open",])*100/input$myslider),"%")
    
  })
  
  output$closedText <- renderText({
    
    paste0("Closed Requests :",ceiling(nrow(dat()[dat()$Status=="Closed",])*100/input$myslider),"%")
    
  })
}
