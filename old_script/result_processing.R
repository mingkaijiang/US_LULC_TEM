### Result processing


myDF <- read.table( "~/Documents/Research/Projects/US_LULE_effect_on_tree/Disturb_Paper/output_files/gpp_lc1700_climate2000_2009.csv",
                    skip = 6)
myDF <- as.matrix(myDF)
myDF <- ifelse(myDF==-1000000, NA, myDF)

rotate <- function(x) t(apply(x, 2, rev))


test <- rotate(myDF)

image(test)
