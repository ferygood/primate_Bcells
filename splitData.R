library(tidyverse)

kat_ext <- read_table("intersect/intersect_katja_ext.csv", skip=1)
kat_tight <- read_table("intersect/intersect_katja_tight.csv", skip=1)

# write function to separate data
splitSpecies <- function(df){
    idxHuman <- which(df$ZNF_ms=="Human")
    idxOran <- which(df$ZNF_ms=="Orangutan")
    
    #return list
    dfChimp <- df[1:(idxHuman-1), ]
    dfHm <- df[(idxHuman+1):(idxOran-1), ]
    dfOran <- df[(idxOran+1):nrow(df), ]
    dfCombined <- list(
        "hm"=dfHm,
        "chimp"=dfChimp,
        "oran"=dfOran
    )
    
    dfCombined
}

kat_ext_split <- splitSpecies(kat_ext)
kat_tight_split <- splitSpecies(kat_tight)

save(kat_ext_split, file="intersect/katja_ext.rda")
save(kat_tight_split, file="intersect/katja_tight.rda")
