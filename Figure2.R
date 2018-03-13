
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


## Plot Veg C
p1 <- ggplot(nceDF) +
    geom_line(aes(x=year, y=LC1700_cum/1000, col="LC1700")) +
    geom_line(aes(x=year, y=LC2011_cum/1000, col="LC2011")) +
    geom_line(aes(x=year, y=LCLUC_NOTIMBER_cum/1000, col="NOTIMBER")) +
    geom_line(aes(x=year, y=LCLUC_2011_cum/1000, col="LULCC")) +
    geom_line(aes(x=year, y=LCLUC_CONST_cum/1000, col="LULCC_CONST")) +
    theme_linedraw() +
    theme(panel.grid.minor=element_blank(),
          axis.text=element_text(size=12),
          axis.title=element_text(size=14),
          legend.text=element_text(size=12),
          legend.title=element_text(size=12, face="bold"),
          legend.position=c(0.25,0.2),
          legend.background = element_rect(size=0.5, linetype="solid"),
          panel.grid.major=element_line(color="grey")) +
    ylim(-50, 10) + 
    xlim(1700, 2011) +
    guides(col=guide_legend(ncol=2)) +
    labs(x="Year", y="Cumulative NCE (PgC)") +
    scale_colour_manual(name="Simulation", 
                        values = c("LC1700" = cbbPalette[4], "LC2011" = cbbPalette[2], 
                                   "NOTIMBER" = cbbPalette[7],
                                   "LULCC" = cbbPalette[1], "LULCC_CONST" = cbbPalette[3]))+
    annotate("text", x = 1710, y = 6, label = "(a)", size=8)

### Disturbance effect on NCE
p2 <- ggplot(nceDF) +
    geom_line(aes(x=year, y=Conversion.Effect, col="Conversion")) +
    geom_line(aes(x=year, y=Timber.Effect, col="Timber")) +
    geom_line(aes(x=year, y=Growth.Enhancements, col="Growth")) +
    theme_linedraw() +
    theme(panel.grid.minor=element_blank(),
          axis.text=element_text(size=12),
          axis.title=element_text(size=14),
          legend.text=element_text(size=12),
          legend.title=element_text(size=12, face="bold"),
          legend.position=c(0.15,0.2),
          legend.background = element_rect(size=0.5, linetype="solid"),
          panel.grid.major=element_line(color="grey")) +
    ylim(-50, 10) + 
    xlim(1700, 2011) +
    labs(x="Year", y="Cumulative NCE (PgC)") +
    scale_colour_manual(name="Scenario", 
                        values = c("Conversion" = cbbPalette[2], "Timber" = cbbPalette[4], 
                                   "Growth" = cbbPalette[6]))+
    annotate("text", x = 1710, y = 6, label = "(b)", size=8)

pdf("Figure2.pdf")
grid.arrange(p1, p2, ncol=1)
dev.off()
