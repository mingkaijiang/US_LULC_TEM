
### read in files
ndep1DF <- read.csv("input/NDEP_sens_kn1.csv")
ndep2DF <- read.csv("input/NDEP_sens_kn2.csv")
co2DF <- read.csv("input/CO2_sens.csv")


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


## Plot sensitivity to timber and ag assumptions
p1 <- ggplot(ndep2DF) +
    geom_line(aes(x=year, y=kn2003_effect/1000, col="kn003")) +
    geom_line(aes(x=year, y=kn2004_effect/1000, col="kn004")) +
    geom_line(aes(x=year, y=kn2005_effect/1000, col="kn005")) +
    theme_linedraw() +
    theme(panel.grid.minor=element_blank(),
          axis.text=element_text(size=12),
          axis.title=element_text(size=14),
          legend.text=element_text(size=12),
          legend.title=element_text(size=14, face="bold"),
          legend.position=c(0.9,0.2),
          legend.background = element_rect(size=0.5, linetype="solid"),
          panel.grid.major=element_line(color="grey")) +
    ylim(-4, 10) + 
    xlim(1700, 2011) +
    labs(x="Year", y="Cumulative NEP (PgC)") +
    scale_colour_manual(name="Sensitivity", 
                        values = c("kn003" = cbbPalette[4], "kn004" = cbbPalette[2], 
                                   "kn005" = cbbPalette[1]))+
    annotate("text", x = 1710, y = 9, label = "(a)", size=8)

### Plot sens to timber and ag
p2 <- ggplot(co2DF) +
    geom_line(aes(x=year, y=CO2_ori/1000, col="kc40")) +
    geom_line(aes(x=year, y=CO2_kc200/1000, col="kc200")) +
    geom_line(aes(x=year, y=CO2_kc400/1000, col="kc400")) +
    theme_linedraw() +
    theme(panel.grid.minor=element_blank(),
          axis.text=element_text(size=12),
          axis.title=element_text(size=14),
          legend.text=element_text(size=12),
          legend.title=element_text(size=14, face="bold"),
          legend.position=c(0.9,0.2),
          legend.background = element_rect(size=0.5, linetype="solid"),
          panel.grid.major=element_line(color="grey")) +
    ylim(-0.5, 3.0) + 
    xlim(1700, 2011) +
    labs(x="Year", y="Cumulative NEP (PgC)") +
    scale_colour_manual(name="Sensitivity", 
                        values = c("kc40" = cbbPalette[1], "kc200" = cbbPalette[2], 
                                   "kc400" = cbbPalette[4])) +
    annotate("text", x = 1710, y = 2.8, label = "(b)", size=8)

pdf("Figure7.pdf")
grid.arrange(p1, p2, ncol=1)
dev.off()

