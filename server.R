## Script:      server.R
## Folder:      UVapp
## Author:      Allen H. Nugent
## Created:     2016-01-26
## Purpose:     Shiny Server file for DS9 Course assignment
# 

library(shiny)
library(ggplot2)

# get input data for models ...

folder.data <- "data"
sunburn.dat <- list()
for (i in 1:4)
{
    dat.in <- read.table(paste0(folder.data, "/", "SkinType", i, ".txt"), 
                         skip = 1, 
                         col.names = c("rownum", "UV.index", "Onset.minutes"))
    sunburn.dat[[i]] <- dat.in[order(dat.in$UV.index), 2:3]
}

# apply linear model to logarithms of input data points ...

sunburn.mod <- lapply(sunburn.dat, lm, formula = log(Onset.minutes) ~ log(UV.index))


# load global data & functions ...

source("global.R")


shinyServer(
    function(input, output) {
        
        # these are control-specific event routines ...
    
        UV.index.in <- reactive({
            input$uvIndex.slider
            # as.numeric(input$uvIndex.slider)
        })
        
        skintype.in <- reactive({
            input$skintype.rdo
        })
        
        environs.in <- reactive({
            input$environs.rdo
        })
        
        # this is the output definition ...
               
        output$plot <- renderPlot({
            
            # get functional variables from user-input settings ...
            
            indx.environs <- which(environs$type == environs.in())
            indx.skintype <- which(skin.types$skin.type == skintype.in())
            UV.index.eff <- UV.index.in() * (1 + environs$UV.reflectance[indx.environs])
            onset.predicted <- onset(UV.index.eff, sunburn.mod[[indx.skintype]])
            minutes.burn <- cround(onset.predicted, 0)
    
            # prepare jaw-dropping visualisation ...
            
            min12hrs <- 60 * 12
            safety.factor <- 0.8
            pie.green <- safety.factor * onset.predicted / min12hrs
            pie.orange <- (1 - safety.factor) * onset.predicted / min12hrs
            pie.red <- (min12hrs - onset.predicted) / min12hrs
            pie.data <- c(pie.green, pie.orange, pie.red)
            
            pie(pie.data, labels = NA, edges = 200, radius = 0.8,
                clockwise = TRUE, col = c("green", "yellow", "red"), border = NA,
                main = paste0(minutes.burn, " minutes to onset of sunburn"))
            
    #        p <- ggplot(dataset(), aes_string(x=input$x, y=input$y)) + geom_point()
            
        }, height = 400)
    }
)



