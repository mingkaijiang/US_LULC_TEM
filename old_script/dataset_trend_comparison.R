### Compare trends across datasets

### inDF
inDF <- read.csv("result/trend_comparison.csv")

inDF1 <- subset(inDF, select = c("year", "nce_fixed_lulcc","nce_cum_fixed_lulcc",
                                 "nep_fixed_lulcc", "nep_cum_flixed_lulcc"))

inDF2 <- subset(inDF, select = c("year", "nce", "nce_cum_old_tem", "nep_old_tem",
                                 "nep_cum_old_tem"))

inDF3 <- subset(inDF, select = c("year", "nce_old_hurtt", "nce_cum_old_hurtt",
                                 "nep_old_hurtt", "nep_cum_old_hurtt"))

inDF1$dataset <- "fixed_lulc"
inDF2$dataset <- "old_tem"
inDF3$dataset <- "old_hurtt"

colnames(inDF3) <- colnames(inDF2) <- colnames(inDF1) <- c("year","nce","nce_cum",
                                                           "nep", "nep_cum","dataset")

myDF <- rbind(inDF1, inDF2)
myDF <- rbind(myDF, inDF3)

### library
require(ggplot2)

### plotting
pdf("trend_comparison.pdf")
p <- ggplot(myDF, aes(x=year, y=nce, group=dataset)) +
    geom_line(aes(color=dataset))
plot(p)

p <- ggplot(myDF, aes(x=year, y=nce_cum, group=dataset)) +
    geom_line(aes(color=dataset))
plot(p)

p <- ggplot(myDF, aes(x=year, y=nep, group=dataset)) +
    geom_line(aes(color=dataset))
plot(p)

p <- ggplot(myDF, aes(x=year, y=nep_cum, group=dataset)) +
    geom_line(aes(color=dataset))
plot(p)

dev.off()

