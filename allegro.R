.libPaths('/home/yaochung41/R/x86_64-pc-linux-gnu-library/4.2')

library(TEKRABber)
library(twice)
library(dplyr)


data("hmKZNFs337")
gene <- read.csv("counts/hm_gene.csv")
te <- read.csv("counts/hm_te.csv")

# remove krab-znfs from gene
gene_filter <- gene[!(gene$gene %in% hmKZNFs337$ensembl_gene_id), ]
rownames(gene_filter) <- gene_filter$gene
gene_filter <- gene_filter[,c(2,3,4)]

# set row names of TE
rownames(te) <- te$name
te <- te[,c(4,5,6)]

set.seed(84)

iter <- c()
percentage <- c()

for (i in 1:1000){
    idx <- sample(8838, size=80)
    gene_table <- gene_filter[idx, ]
    #myfile <- paste0(format(Sys.time(), "%s_%b_%d", ".csv"))
    
    result <- corrOrthologTE(
        gene_table,
        te
    )
    
    count <- length(unique(result$geneName))
    result.sig <- result %>%
        filter(padj < 0.05)
    count.sig <- length(unique(result.sig$geneName))
    iter <- c(iter, as.character(i))
    percentage <- c(percentage, count.sig/count)
}

df_output <- data.frame(
    num = iter,
    per = percentage
)


write.table(df_output, file="hm_results/percentage_result_1000/percentage.csv", sep = ",")
