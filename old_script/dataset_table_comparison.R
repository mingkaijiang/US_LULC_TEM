#### Make comparisons on the follow 4 datasets

### library
require(ggplot2)

### read in files
fixed_lulc <- read.csv("result/fixed_LULCC.csv")
old_hurtt <- read.csv("result/old_hurtt.csv")
lu_etal <- read.csv("result/lu_etal.csv")
old_tem <- read.csv("result/old_tem.csv")

### add dataset names
fixed_lulc$dataset <- "fixed_lulc"
old_hurtt$dataset <- "old_hurtt"
lu_etal$dataset <- "lu_etal"
old_tem$dataset <- "old_tem"

### combine the dataset
common_cols <- intersect(colnames(fixed_lulc),
                          intersect(colnames(old_hurtt), 
                                    intersect(colnames(lu_etal), colnames(old_tem))))

myDF <- rbind(subset(fixed_lulc, select = common_cols), 
              subset(old_hurtt, select = common_cols))
myDF <- rbind(myDF, subset(lu_etal, select = common_cols))
myDF <- rbind(myDF, subset(old_tem, select = common_cols))

colnames(myDF) <- c("Landcover", "NEP", "Livestock_Resp",
                    "Conversion_Flux", "Ag_Products",
                    "X10_Yr_Products", "X100_Yr_Products",
                    "NCE", "NCE_Calc", "Tot_PRDFC_Calc",
                    "dataset")

### compare variables across datasets

pdf("dataset_comparisons.pdf")
p <- ggplot(myDF, aes(x=dataset, y=NEP, fill=Landcover)) + 
    geom_bar(stat="identity") + 
    ggtitle("NEP comparison")
plot(p)

p <- ggplot(myDF, aes(x=dataset, y=NCE, fill=Landcover)) + 
    geom_bar(stat="identity") + 
    ggtitle("NCE comparison")
plot(p)

p <- ggplot(myDF, aes(x=dataset, y=NCE_Calc, fill=Landcover)) + 
    geom_bar(stat="identity") + 
    ggtitle("NCE Calc comparison")
plot(p)

p <- ggplot(myDF, aes(x=dataset, y=Tot_PRDFC_Calc, fill=Landcover)) + 
    geom_bar(stat="identity") + 
    ggtitle("Tot PRDFC Calc comparison")
plot(p)

p <- ggplot(myDF, aes(x=dataset, y=Livestock_Resp, fill=Landcover)) + 
    geom_bar(stat="identity") +
    ggtitle("Livestock Respiration")
plot(p)

p <- ggplot(myDF, aes(x=dataset, y=Conversion_Flux, fill=Landcover)) + 
    geom_bar(stat="identity") +
    ggtitle("Conversion flux")
plot(p)

p <- ggplot(myDF, aes(x=dataset, y=Ag_Products, fill=Landcover)) + 
    geom_bar(stat="identity") +
    ggtitle("Agricultural production")
plot(p)

p <- ggplot(myDF, aes(x=dataset, y=X10_Yr_Products, fill=Landcover)) + 
    geom_bar(stat="identity") +
    ggtitle("X10_Yr_Products")
plot(p)

p <- ggplot(myDF, aes(x=dataset, y=X100_Yr_Products, fill=Landcover)) + 
    geom_bar(stat="identity") +
    ggtitle("X100_Yr_Products")
plot(p)

dev.off()