
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#


#
#Running in separate process
#
# R -e "shiny::runApp('~/shinyapp')"

library(shiny)

shinyUI(pageWithSidebar(
  # Application title
  headerPanel("Mtcars dataset analysis"),

  # Sidebar with a slider input for number of bins
  #Sidebar layout ide uz fluid page
  #sidebarLayout(
  
  #definisanje ulaza
  sidebarPanel(
    
    helpText("The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models)."),
    selectInput("variable", "Variable:",
                list("Cylinders" = "cyl", 
                     "Displacement" = "disp",
                     "Gross horsepower" = "hp",
                     "Rear axle ratio" = "drat",
                     "Weight" = "wt",
                     "1/4 mile time" = "qsec",
                     "V/S" = "vs",
                     "Transmission" = "am", 
                     "Gears" = "gear",
                     "Number of carburators"="carb"))
  
    ),
  


   
  # Show the caption and plot of the requested variable against mpg
  mainPanel(
    h3(textOutput("caption")),
    
    
    tabsetPanel(
     
      tabPanel("Plot",  helpText("Boxplot is convinient way fo initial correllation check (i.e. how are inputs related to output)"),
                        
               
               checkboxInput("outliers", "Show outliers", FALSE),plotOutput("mpgPlot")),
      tabPanel("Summary", helpText("Summary gives common data statistics per variable (min,max,median etc)"),
               verbatimTextOutput("summary")), 
      tabPanel("Table",helpText("Table gives all values of variable in dataset"),
               tableOutput("table")),
      tabPanel("Fit",helpText("Simple mpg~x fit where x is single variable selected"),
               verbatimTextOutput("text"))
    ),
    tableOutput("values")
  )
  #)
))