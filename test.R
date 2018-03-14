### read in files
vegcDF <- read.csv("input/VEGC.csv")
nceDF <- read.csv("input/NCE.csv")

### plotting settings
# two nice color palette for color blind
# The palette with grey:
cbPalette <- c("#999999", "#E69F00", "#56B4E9",
               "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# The palette with black:
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", 
                "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

require(ggplot2)
require(gridExtra)

# create decadal time series
d <- c("1950s", "1960s", "1970s", "1980s", "1990s", "2000s")
dDF1 <- data.frame(d, NA, NA)
colnames(dDF1) <- c("Decade", "NCE", "Experiment")

dDF4 <- dDF3 <- dDF2 <- dDF1


dDF1[dDF1$Decade == "1950s", "NCE"] <- mean(nceDF[nceDF$year >=1951 & nceDF$year <= 1960, "LCLUC_2011"])
dDF1[dDF1$Decade == "1960s", "NCE"] <- mean(nceDF[nceDF$year >=1961 & nceDF$year <= 1970, "LCLUC_2011"])
dDF1[dDF1$Decade == "1970s", "NCE"] <- mean(nceDF[nceDF$year >=1971 & nceDF$year <= 1980, "LCLUC_2011"])
dDF1[dDF1$Decade == "1980s", "NCE"] <- mean(nceDF[nceDF$year >=1981 & nceDF$year <= 1990, "LCLUC_2011"])
dDF1[dDF1$Decade == "1990s", "NCE"] <- mean(nceDF[nceDF$year >=1991 & nceDF$year <= 2000, "LCLUC_2011"])
dDF1[dDF1$Decade == "2000s", "NCE"] <- mean(nceDF[nceDF$year >=2001 & nceDF$year <= 2010, "LCLUC_2011"])

dDF1$Experiment <- "LULCC"

dDF2[dDF2$Decade == "1950s", "NCE"] <- mean(nceDF[nceDF$year >=1951 & nceDF$year <= 1960, "LCLUC_NOTIMBER"])
dDF2[dDF2$Decade == "1960s", "NCE"] <- mean(nceDF[nceDF$year >=1961 & nceDF$year <= 1970, "LCLUC_NOTIMBER"])
dDF2[dDF2$Decade == "1970s", "NCE"] <- mean(nceDF[nceDF$year >=1971 & nceDF$year <= 1980, "LCLUC_NOTIMBER"])
dDF2[dDF2$Decade == "1980s", "NCE"] <- mean(nceDF[nceDF$year >=1981 & nceDF$year <= 1990, "LCLUC_NOTIMBER"])
dDF2[dDF2$Decade == "1990s", "NCE"] <- mean(nceDF[nceDF$year >=1991 & nceDF$year <= 2000, "LCLUC_NOTIMBER"])
dDF2[dDF2$Decade == "2000s", "NCE"] <- mean(nceDF[nceDF$year >=2001 & nceDF$year <= 2010, "LCLUC_NOTIMBER"])

dDF2$Experiment <- "NOTIMBER"


dDF3[dDF3$Decade == "1950s", "NCE"] <- mean(nceDF[nceDF$year >=1951 & nceDF$year <= 1960, "LCLUC_CONST"])
dDF3[dDF3$Decade == "1960s", "NCE"] <- mean(nceDF[nceDF$year >=1961 & nceDF$year <= 1970, "LCLUC_CONST"])
dDF3[dDF3$Decade == "1970s", "NCE"] <- mean(nceDF[nceDF$year >=1971 & nceDF$year <= 1980, "LCLUC_CONST"])
dDF3[dDF3$Decade == "1980s", "NCE"] <- mean(nceDF[nceDF$year >=1981 & nceDF$year <= 1990, "LCLUC_CONST"])
dDF3[dDF3$Decade == "1990s", "NCE"] <- mean(nceDF[nceDF$year >=1991 & nceDF$year <= 2000, "LCLUC_CONST"])
dDF3[dDF3$Decade == "2000s", "NCE"] <- mean(nceDF[nceDF$year >=2001 & nceDF$year <= 2010, "LCLUC_CONST"])

dDF3$Experiment <- "LULCC_CONST"


dDF4[dDF4$Decade == "1950s", "NCE"] <- mean(nceDF[nceDF$year >=1951 & nceDF$year <= 1960, "LC2011"])
dDF4[dDF4$Decade == "1960s", "NCE"] <- mean(nceDF[nceDF$year >=1961 & nceDF$year <= 1970, "LC2011"])
dDF4[dDF4$Decade == "1970s", "NCE"] <- mean(nceDF[nceDF$year >=1971 & nceDF$year <= 1980, "LC2011"])
dDF4[dDF4$Decade == "1980s", "NCE"] <- mean(nceDF[nceDF$year >=1981 & nceDF$year <= 1990, "LC2011"])
dDF4[dDF4$Decade == "1990s", "NCE"] <- mean(nceDF[nceDF$year >=1991 & nceDF$year <= 2000, "LC2011"])
dDF4[dDF4$Decade == "2000s", "NCE"] <- mean(nceDF[nceDF$year >=2001 & nceDF$year <= 2010, "LC2011"])

dDF4$Experiment <- "LC2011"

dDF <- rbind(dDF1, dDF2, dDF3, dDF4)
    
    
## Plot NCE
p <- ggplot(dDF) +
    geom_bar(aes(x=Decade, y=NCE, fill=Experiment),
    stat="identity", position=position_dodge()) +
    theme_linedraw() +
    theme(panel.grid.minor=element_blank(),
          axis.text=element_text(size=12),
          axis.title=element_text(size=14),
          legend.text=element_text(size=12),
          legend.title=element_text(size=14, face="bold"),
          legend.position=c(0.85,0.85),
          panel.grid.major=element_line(color="grey")) + 
    ylim(-100, 300) + 
    ylab(expression(paste("NCE (TgC", yr^-1, ")"))) + xlab("Decade") +
    scale_fill_manual(name="Experiment", values = c("LULCC" = cbPalette[2], "NOTIMBER" = cbPalette[3],
                                                   "LULCC_CONST" = cbPalette[4], "LC2011" = cbPalette[7]))





#### pdf output
pdf("Figure1.pdf")
plot(p)
dev.off()
 