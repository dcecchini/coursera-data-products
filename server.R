#
# This is the server logic of the Shiny web application "FractalView". 
#
# Author: David Amore Cecchini
# 
#

library(shiny)
library(memoise)


## Function to generate the Mabdelbrot set according to the 'color_mode' chosen by the user
MandelbrotSet <- memoise(function (color_mode) {
    
    
    ## Define variables
    max_iteration = 100
    xmin=-2
    xmax=1
    nx=400
    ymin=-1
    ymax=1.25
    ny=400
    x0=-2
    y0=1.25
    
    # The variable 'y0_aux' is an auxiliary variable for loop control
    y0_aux <- y0
    
    # The lenght of the intervals on the image
    dx <- (xmax - xmin)/nx
    dy <- (ymax - ymin)/nx
    
    ## Declare the plot
    plot(NULL, xlim=c(1,nx),ylim=c(1,ny), type='n', axes=F, yaxs='i',xaxs='i',xlab="Re(c)", ylab="Im(c)")
    
    for(i in 1:nx){
        for(j in 1:ny){
            
            x <- x0
            y <- y0
            iter <- 0

            while((x*x + y*y) <= 4 && iter < max_iteration){
                x_aux <- x*x - y*y + x0
                y <- 2*x*y + y0

                x <- x_aux

                iter <- iter + 1
            }
            
            ## Depending on each 'color_mode' chosen, the color to be printed will change
            ## First case: Color depending on the distance to the border of the set
            if(color_mode == "Distance to border"){
                if(iter < max_iteration){
                    log_zn <- log(x*x + y*y) / 2
                    nu <- log(log_zn/log(2))/log(2)
                    
                    iter <- iter + 1 - nu
                }
                
                color <- iter
            ## Second case: Color only the point where x*y is positive according to
                ## the distance to the border of the set
            }else if(color_mode == "XY positive"){
                if(x*y > 0)
                    color <- iter
                else color <- 0
            ## Third case: Color only the interior of the set
            }else if (color_mode == "Interior of the set"){
                if((x*x + y*y) < 4)
                    color <- 100
                else color <- 0
            }
            
            ## Print the point in the image
            points(i,j,col=color)
            
            y0 <- y0 - dy
        }
        
        y0 <- y0_aux
        x0 <- x0+dx
    }
    
})

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
    output$mandelbrotSet <- renderPlot({
      
        color_choice <- input$input_color_mode
        
        MandelbrotSet(color_choice)
    })
})
