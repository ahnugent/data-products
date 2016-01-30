## Script:      global.R
## Folder:      UVapp
## Author:      Allen H. Nugent
## Created:     2016-01-26
## Purpose:     Shared data initialisation file for Shiny app in DS9 Course assignment
##


# custom functions used ...

# round and format a number with a non-ridiculous number of decimals:
cround <- function(x, ndec)   
{
    if (ndec == 0)
    {
        fmt1 <- "%d"
    } else 
    {
        fmt1 <- paste0("%.", ndec, "f")
    }
    result <- sprintf(fmt = fmt1, round(x, ndec))
    return(result)
}

# perform prediction using a log-log linear model:
onset <- function(UV.index, modFit)   
{
    result <- exp(modFit$coef[1]) * UV.index ^ modFit$coef[2]
    return(result)
}


# populate the lookup table for skin type ...

skin.types <- data.frame(skin.type = c("I", "II", "III", "IV"), 
                         series.colour = c("yellow", "orange", "dark orange", "brown"),
                         hair.colour = c("red", "blond", "brown", "black"),
                         tan = c("never", "sometimes", "always", "always"),
                         burn = c("always", "sometimes", "rarely", "never"),
                         stringsAsFactors = FALSE)

# colours are used fro plotting data 
# (currently featured only in non-Shiny version of project) ...

skin.types$series.colour.rgb <- c("#FFFF00", "#FF8000", "#CC6600", "#994C00")


# populate the lookup table for UV augmentation by environs ...

environs <- data.frame(type = c("grass", "soil", "sand", "water", "snow"), 
                       UV.reflectance = c(0.20, 0.10, 0.25, 0.50, 0.80),
                       stringsAsFactors = FALSE)


