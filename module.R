# Input csv ####
# CSV input
csvFileInput <- function(id){
  ns <- NS(id)
  
  fileInput(ns("file"), "Select csv file.",
            accept = c(
              "text/csv",
              "text/comma-separated-values,text/plain",
              ".csv")
  )
}

csvFile <- function(input, output, session){
  userFile <- reactive({
    # If no file is selected, don't do anything
    validate(need(input$file, message = FALSE))
    input$file
  })
  
  dataframe <- reactive({
    read_csv(userFile()$datapath
    )
  })
  
  return(dataframe)
}

# Plate input
PlateFileInput <- function(id){
  ns <- NS(id)
  
  fileInput(ns("file"), "Select csv file.",
            accept = c(
              "text/csv",
              "text/comma-separated-values,text/plain",
              ".csv")
  )
}

PlateFile <- function(input, output, session){
  userFile <- reactive({
    # If no file is selected, don't do anything
    validate(need(input$file, message = FALSE))
    input$file
  })
  
  dataframe <- reactive({
    read_plate(userFile()$datapath
    )
  })
  
  return(dataframe)
}
