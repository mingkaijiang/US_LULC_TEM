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


## Plot Veg C
p1 <- ggplot(vegcDF) +
    geom_line(aes(x=year, y=LC1700/1000, col="LC1700")) +
    geom_line(aes(x=year, y=LC2011/1000, col="LC2011")) +
    geom_line(aes(x=year, y=LCLUC_NOTIMBER/1000, col="NOTIMBER")) +
    geom_line(aes(x=year, y=LCLUC_2011/1000, col="LULCC")) +
    geom_line(aes(x=year, y=LCLUC_CONST/1000, col="LULCC_CONST")) +
    theme_linedraw() +
    theme(panel.grid.minor=element_blank(),
          axis.text=element_text(size=12),
          axis.title=element_text(size=14),
          legend.text=element_text(size=12),
          legend.title=element_text(size=12, face="bold"),
          legend.position="none",
          legend.background = element_rect(size=0.5, linetype="solid"),
          panel.grid.major=element_line(color="grey")) +
    ylim(10, 80) + 
    xlim(1700, 2011) +
    guides(col=guide_legend(ncol=2)) +
    labs(x="Year", y="Vegetation Carbon (PgC)") +
    scale_colour_manual(name="Experiment", 
                        values = c("LC1700" = cbbPalette[4], "LC2011" = cbbPalette[2], 
                                   "NOTIMBER" = cbbPalette[7],
                                   "LULCC" = cbbPalette[1], "LULCC_CONST" = cbbPalette[3]))+
    annotate("text", x = 1710, y = 76, label = "(a)", size=8)

### Disturbance effect on veg C
p2 <- ggplot(vegcDF) +
    geom_area(aes(x=year, y=Conversion.Effect, fill="Conversion")) +
    geom_area(aes(x=year, y=Timber.Effect, fill="Timber")) +
    geom_area(aes(x=year, y=Growth.Enhancements, fill="Growth")) +
    theme_linedraw() +
    theme(panel.grid.minor=element_blank(),
          axis.text=element_text(size=12),
          axis.title=element_text(size=14),
          legend.text=element_text(size=12),
          legend.title=element_text(size=12, face="bold"),
          legend.position="none",
          legend.background = element_rect(size=0.5, linetype="solid"),
          panel.grid.major=element_line(color="grey")) +
    ylim(-40, 10) + 
    xlim(1700, 2011) +
    labs(x="Year", y="Vegetation Carbon (PgC)") +
    scale_fill_manual(name="Effect", 
                      values = c("Conversion" = cbbPalette[8], "Timber" = cbbPalette[5], 
                                 "Growth" = cbbPalette[4])) +
    annotate("text", x = 1710, y = 6, label = "(b)", size=8)


## Plot NCE
p3 <- ggplot(nceDF) +
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
          legend.position=c(0.2,0.25),
          legend.background = element_rect(size=0.5, linetype="solid"),
          panel.grid.major=element_line(color="grey")) +
    ylim(-50, 10) + 
    xlim(1700, 2011) +
    labs(x="Year", y="Cumulative NCE (PgC)") +
    scale_colour_manual(name="Simulation", 
                        values = c("LC1700" = cbbPalette[4], "LC2011" = cbbPalette[2], 
                                   "NOTIMBER" = cbbPalette[7],
                                   "LULCC" = cbbPalette[1], "LULCC_CONST" = cbbPalette[3]))+
    annotate("text", x = 1710, y = 6, label = "(c)", size=8)

### Disturbance effect on NCE
p4 <- ggplot(nceDF) +
    geom_area(aes(x=year, y=Conversion.Effect, fill="Conversion")) +
    geom_area(aes(x=year, y=Timber.Effect, fill="Timber")) +
    geom_area(aes(x=year, y=Growth.Enhancements, fill="Growth")) +
    theme_linedraw() +
    theme(panel.grid.minor=element_blank(),
          axis.text=element_text(size=12),
          axis.title=element_text(size=14),
          legend.text=element_text(size=12),
          legend.title=element_text(size=12, face="bold"),
          legend.position=c(0.2,0.2),
          legend.background = element_rect(size=0.5, linetype="solid"),
          panel.grid.major=element_line(color="grey")) +
    ylim(-50, 10) + 
    xlim(1700, 2011) +
    labs(x="Year", y="Cumulative NCE (PgC)") +
    scale_fill_manual(name="Effect", 
                      values = c("Conversion" = cbbPalette[8], "Timber" = cbbPalette[5], 
                                 "Growth" = cbbPalette[4]))+
    annotate("text", x = 1710, y = 6, label = "(d)", size=8)





#### pdf output
pdf("Figure2.pdf", width=10, height=8)
grid.arrange(p1, p2, p3, p4, ncol=2)
dev.off()
 