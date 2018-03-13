
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
    geom_line(aes(x=year, y=TIMBER_SENS_cum/1000, col="Timber Lu et al")) +
    geom_line(aes(x=year, y=AG_SENS_CUM/1000, col="Ag burning")) +
    geom_line(aes(x=year, y=X500_SENS_cum/1000, col="Ag 500")) +
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
    scale_colour_manual(name="Sensitivity", 
                        values = c("Timber Lu et al" = cbbPalette[4], "Ag burning" = cbbPalette[2], 
                                   "Ag 500" = cbbPalette[7],
                                   "LULCC" = cbbPalette[1]))+
    annotate("text", x = 1710, y = 6, label = "(a)", size=8)

### Plot sens to timber and ag
p2 <- ggplot(nceDF) +
    geom_area(aes(x=year, y=timber_effect_sens, fill="Timber Lu et al")) +
    geom_area(aes(x=year, y=Timber.Effect, fill="Timber")) +
    geom_area(aes(x=year, y=X500_effect_sens, fill="Ag 500")) +
    geom_area(aes(x=year, y=ag_sens, fill="Ag burning")) +
    theme_linedraw() +
    theme(panel.grid.minor=element_blank(),
          axis.text=element_text(size=12),
          axis.title=element_text(size=14),
          legend.text=element_text(size=12),
          legend.title=element_text(size=12, face="bold"),
          legend.position=c(0.2,0.25),
          legend.background = element_rect(size=0.5, linetype="solid"),
          panel.grid.major=element_line(color="grey")) +
    ylim(-15, 5) + 
    xlim(1700, 2011) +
    guides(col=guide_legend(ncol=2)) +
    labs(x="Year", y="Cumulative NCE (PgC)") +
    scale_fill_manual(name="Effect", 
                        values = c("Ag burning" = cbbPalette[7], "Timber" = cbbPalette[6], 
                                   "Ag 500" = cbbPalette[2], 
                                   "Timber Lu et al" = cbbPalette[3])) +
    annotate("text", x = 1710, y = 4, label = "(b)", size=8)

pdf("Figure6.pdf")
grid.arrange(p1, p2, ncol=1)
dev.off()

