#!/usr/bin/env Rscript
library(Seurat)
library(future)

message("Loading Seurat object")
load(file = "data/rna.integrated.filtered.after.clustering.obj.RData")

# create new Idents: saline/freshwater
samples.to.water.type <- data.frame("samples" = c("stickleback.sample.1",
                                                  "stickleback.sample.2",
                                                  "stickleback.sample.3",
                                                  "stickleback.sample.4"),
                                    "water.type" = c("fresh",
                                                     "fresh",
                                                     "saline",
                                                     "saline"))

rna.integrated$salinity <- merge(data.frame(rna.integrated$orig.ident),
                                               samples.to.water.type,
                                               by.x="rna.integrated.orig.ident",
                                               by.y="samples")$water.type
Idents(rna.integrated) <- "salinity"

plan("multiprocess", workers = 11)
message("Calculating markers")
DE.blood.by.salinity.all <- FindMarkers(rna.integrated,
                                                    ident.1 = "fresh",
                                                    ident.2 = "saline",
                                                    verbose = FALSE,
                                                    logfc.threshold = 0)
message("Writing markers to file")
write.csv(DE.blood.by.salinity.all, file = "data/DEGs.by.salinity.all.csv")