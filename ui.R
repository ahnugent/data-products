## Script:      ui.R
## Folder:      UVapp
## Author:      Allen H. Nugent
## Created:     2016-01-26
## Purpose:     Shiny UI file for DS9 Course assignment
##
## 

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  

# Set up environment ...

#         setwd("E:/R_data/Course9_Ass1/UVapp")
#         library(shiny)   
        
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  


# load global data & functions ...

source("global.R")


# design the web page ...

shinyUI(
    fluidPage(
        
        titlePanel("Sunburn versus UV Dose"),
        
        br(),

        sidebarPanel(
            
            sliderInput("uvIndex.slider", "UV Index", min = 2, max = 12,
                        value = 2, step = 0.1),
            
            selectInput("environs.rdo", "Environs", environs$type, environs$type[1]),
            
            selectInput("skintype.rdo", "Skin Type", skin.types$skin.type, skin.types$skin.type[[2]]),

            # this won't work because Shiny doesn't allow &nbsp; and doesn't generate table cell borders ...
#             br(),
#             p("Skin Types:"),
#             with(skin.types, div(tags$table(tags$tr(tags$th("Skin Type:"), tags$th(skin.type[1]), tags$th(skin.type[2]), tags$th(skin.type[3]), tags$th(skin.type[4])),
#                                  tags$tr(tags$th("Hair Colour:  "), tags$th(paste0("  ", hair.colour[1])), tags$th(hair.colour[2]), tags$th(hair.colour[3]), tags$th(hair.colour[4])))  ))
            
            br(),
            img(src = "skin_types_table.png", width = 250)
        ),
        
        mainPanel(
    
    #         br(),
    #         div("The time to onset of sunburn (erythema) depends on the intensity of
    #             UV radiation (UV index), the skin type, and the UV reflectance of surfaces in the environs.")
            
            plotOutput("plot")
        ),

        wellPanel(
            
            helpText(a("Click to view documentation", href="https://github.com/ahnugent/data-products/blob/master/UVapp_doco.pdf"))
        )
    )
)
