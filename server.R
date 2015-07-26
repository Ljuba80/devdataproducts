
library(shiny)
library(datasets)

mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))

shinyServer(function(input, output) {

  formulaText <- reactive({
    paste("mpg ~", input$variable)
  })
  
  var <- reactive({
    switch(input$variable,
           "cyl" = mpgData$cyl,
           "disp" = mpgData$disp,
           "hp" = mpgData$hp,
           "drat" = mpgData$drat,
           "wt" = mpgData$wt,
           "qsec" = mpgData$qsec,
           "vs" = mpgData$vs,
           "am" = mpgData$am,
           "gear" = mpgData$gear,
           "carb" = mpgData$carb,
           )
  })
  # Return the formula text for printing as a caption
  output$caption <- renderText({
    formulaText()
  })
  
  # Generate a plot of the requested variable against mpg and only 
  # include outliers if requested
  output$mpgPlot <- renderPlot({
    boxplot(as.formula(formulaText()), 
            data = mpgData,
            outline = input$outliers)
    
  })
  
 
  output$summary <- renderPrint({
    summary(mpgData[input$variable])
  })
  
  output$text <- renderPrint({
    model <- lm(mpg ~ var(), data=mtcars)
    names(model[1]$coefficients)=c("(Intercept)",input$variable);
    model
  })
  
  output$table <- renderTable({
    data.frame(x=mpgData[input$variable])
  })
  
})
