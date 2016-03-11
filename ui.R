#
# This is the user-interface definition of the Shiny web application "FractalView". 
#
# Author: David Amore Cecchini
# 
# 

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("The Mandelbrot Set: Mathematical Art"),
  
  # Sidebar with a slider input for number of bincs 
  sidebarLayout(
    sidebarPanel(
        h3("Description"),
        p("This application is very simple. You select a option to color the image of the Mandelbrot Set and 
          it generates a new image."),
        p("Please be patient because the code take some time to run."),
        selectInput("input_color_mode", "Choose one of the color options", 
                    choices = c("Interior of the set", "Distance to border", "XY positive"),
                    selected="Interior of the set")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        div(
            p("See the Mandelbrot Set below:")
        ),
        
        column(8, align="center",
            plotOutput("mandelbrotSet", width = 400, height = 400)
        )
    )
  )
))
