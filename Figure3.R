### necessary functions
rotate <- function(x) t(apply(x, 2, rev))

### library
library(raster)
library(RColorBrewer)


### Result processing 1
myDF1 <- read.table( "~/Documents/Research/Projects/US_LULE_effect_on_tree/Disturb_Paper/output_files/nce_lulcc_20112000_2009.map",
                    skip = 6)
myDF1 <- as.matrix(myDF1)
myDF1 <- ifelse(myDF1==-1000000, NA, myDF1)


myDF2 <- read.table( "~/Documents/Research/Projects/US_LULE_effect_on_tree/Disturb_Paper/output_files/nce_lc1700.2000_2009.map",
                     skip = 6)
myDF2 <- as.matrix(myDF2)
myDF2 <- ifelse(myDF2==-1000000, NA, myDF2)

## matrix deduction
myDF <- myDF1 - myDF2

## make raster     
r1 <- raster(myDF)


### Result processing 2
myDF3 <- read.table( "~/Documents/Research/Projects/US_LULE_effect_on_tree/Disturb_Paper/output_files/nce_lulcc_const2000_2009.map",
                     skip = 6)
myDF3 <- as.matrix(myDF3)
myDF3 <- ifelse(myDF3==-1000000, NA, myDF3)

## matrix deduction
myDF <- myDF1 - myDF3

## make raster     
r2 <- raster(myDF)


### Plotting
test.col1 <- brewer.pal(6, "RdYlGn")
plot(r1, breaks=c(-250, -100, -10, 10, 50, 100, 150),
     col=test.col1,
     axes=F)


test.col2 <- brewer.pal(8, "RdYlGn")
plot(r2, breaks=c(-200, -100, -67, -33, 0, 33, 67, 100, 800),
     col=test.col2,
     axes=F)




