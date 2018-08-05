
### read in files
nceDF <- read.csv("input/NCE.csv")
vegcDF <- read.csv("input/VEGC.csv")

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
    geom_area(aes(x=year, y=LCLUC,  fill="LULCC")) +
    geom_area(aes(x=year, y=O3, fill="O3")) +
    geom_area(aes(x=year, y=Climate, fill="Climate")) +
    geom_area(aes(x=year, y=Ndep, fill="Ndep")) +
    geom_area(aes(x=year, y=CO2, fill="CO2")) +
    theme_linedraw() +
    theme(panel.grid.minor=element_blank(),
          axis.text=element_text(size=12),
          axis.title=element_text(size=14),
          legend.text=element_text(size=12),
          legend.title=element_text(size=12, face="bold"),
          legend.position="none",
          legend.background = element_rect(size=0.5, linetype="solid"),
          panel.grid.major=element_line(color="grey")) +
    ylim(-50, 10) + 
    xlim(1700, 2011) +
    guides(col=guide_legend(ncol=2)) +
    labs(x="Year", y="Vegetation Carbon (PgC)") +
    scale_fill_manual(name="Effect", 
                        values = c("Climate" = cbbPalette[2], "Ndep" = cbbPalette[7],
                                   "O3" = cbbPalette[5], "CO2" = cbbPalette[3], 
                                   "LULCC" = cbbPalette[4]))+
    annotate("text", x = 1710, y = 6, label = "(a)", size=8)

### Disturbance effect on veg C
p2 <- ggplot(nceDF) +
    geom_area(aes(x=year, y=LCLUC,  fill="LULCC")) +
    geom_area(aes(x=year, y=O3, fill="O3")) +
    geom_area(aes(x=year, y=Climate, fill="Climate")) +
    geom_area(aes(x=year, y=Ndep, fill="Ndep")) +
    geom_area(aes(x=year, y=CO2, fill="CO2")) +
    theme_linedraw() +
    theme(panel.grid.minor=element_blank(),
          axis.text=element_text(size=12),
          axis.title=element_text(size=14),
          legend.text=element_text(size=12),
          legend.title=element_text(size=12, face="bold"),
          legend.position=c(0.2,0.3),
          legend.background = element_rect(size=0.5, linetype="solid"),
          panel.grid.major=element_line(color="grey"),
          legend.text.align=0) +
    ylim(-50, 20) + 
    xlim(1700, 2011) +
    labs(x="Year", y="Cumulative NCE (PgC)") +
    scale_fill_manual(name="Effect", 
                      values = c("Climate" = cbbPalette[2], "Ndep" = cbbPalette[7],
                                 "O3" = cbbPalette[5], "CO2" = cbbPalette[3], 
                                 "LULCC" = cbbPalette[4]),
                      labels = c(expression(paste({E}^4.1, " Climate")),
                                 expression(paste({E}^4.4, " CO2")),
                                 expression(paste({E}^1.2, " LULCC")),
                                 expression(paste({E}^4.2, " Ndep")),
                                 expression(paste({E}^4.3, " O3"))))+
    annotate("text", x = 1710, y = 16, label = "(b)", size=8)

pdf("Figure4.pdf")
grid.arrange(p1, p2, ncol=1)
dev.off()

