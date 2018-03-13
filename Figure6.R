
### read in files
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


## Plot sensitivity to timber and ag assumptions
p1 <- ggplot(nceDF) +
    geom_line(aes(x=year, y=TIMBER_SENS_cum/1000, col="TIMBER")) +
    geom_line(aes(x=year, y=AG_SENS_CUM/1000, col="AGRICULTURE")) +
    geom_line(aes(x=year, y=X500_SENS_cum/1000, col="500PRODUCT")) +
    geom_line(aes(x=year, y=LCLUC_2011_cum/1000, col="LULCC")) +
    theme_linedraw() +
    theme(panel.grid.minor=element_blank(),
          axis.text=element_text(size=12),
          axis.title=element_text(size=14),
          legend.text=element_text(size=12),
          legend.title=element_text(size=12, face="bold"),
          legend.position=c(0.25,0.2),
          legend.background = element_rect(size=0.5, linetype="solid"),
          panel.grid.major=element_line(color="grey")) +
    ylim(-60, 10) + 
    xlim(1700, 2011) +
    guides(col=guide_legend(ncol=2)) +
    labs(x="Year", y="Cumulative NCE (PgC)") +
    scale_colour_manual(name="Simulation", 
                        values = c("TIMBER" = cbbPalette[4], "AGRICULTURE" = cbbPalette[2], 
                                   "500PRODUCT" = cbbPalette[7],
                                   "LULCC" = cbbPalette[1]))+
    annotate("text", x = 1710, y = 6, label = "(a)", size=8)

### Plot sens to timber and ag
p2 <- ggplot(nceDF) +
    geom_line(aes(x=year, y=ag_sens, col="Ag")) +
    geom_line(aes(x=year, y=Timber.Effect, col="Timber")) +
    geom_line(aes(x=year, y=timber_effect_sens, col="Timber Lu et al")) +
    geom_line(aes(x=year, y=X500_effect_sens, col="Ag Lu et al")) +
    theme_linedraw() +
    theme(panel.grid.minor=element_blank(),
          axis.text=element_text(size=12),
          axis.title=element_text(size=14),
          legend.text=element_text(size=12),
          legend.title=element_text(size=12, face="bold"),
          legend.position=c(0.25,0.2),
          legend.background = element_rect(size=0.5, linetype="solid"),
          panel.grid.major=element_line(color="grey")) +
    ylim(-15, 5) + 
    xlim(1700, 2011) +
    guides(col=guide_legend(ncol=2)) +
    labs(x="Year", y="Cumulative NCE (PgC)") +
    scale_colour_manual(name="Scenario", 
                        values = c("Ag" = cbbPalette[7], "Timber" = cbbPalette[6], 
                                   "Ag Lu et al" = cbbPalette[2], 
                                   "Timber Lu et al" = cbbPalette[3])) +
    annotate("text", x = 1710, y = 4, label = "(b)", size=8)

pdf("Figure6.pdf")
grid.arrange(p1, p2, ncol=1)
dev.off()

