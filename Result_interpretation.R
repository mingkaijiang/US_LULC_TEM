#### Make comparisons on the follow 4 datasets

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



### compare NEP across datasets
