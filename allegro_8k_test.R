# run 8919 genes with 992 TEs using TEKRABber

.libPaths('/home/yaochung41/R/x86_64-pc-linux-gnu-library/4.2')

library(TEKRABber)
library(twice)
library(dplyr)

data("hmKZNFs337")
gene <- read.csv("counts/hm_gene.csv")
te <- read.csv("counts/hm_te.csv")

# create gene input data
df_gene <- gene
rownames(df_gene) <- gene$gene
df_gene <- df_gene[,c(2,3,4)]

# create te input data
df_te <- te
rownames(df_te) <- te$name
df_te <- df_te[,c(4,5,6)]

# run correlation, first 10 rows
corrOrthologTE(
    geneInput = df_gene[c(1:10), ],
    teInput = df_te[c(1:10), ],
    padjMethod = "fdr",
    fileDir = "hm_results"
)
