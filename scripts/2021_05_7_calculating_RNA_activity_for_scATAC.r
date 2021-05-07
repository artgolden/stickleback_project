#!/usr/bin/env Rscript
library(Signac)
library(Seurat)
library(future)


setwd("/home/tema/work/skolkovo/fish_project/")


message("Loading Seurat object")
load(file = "data/scATAC/atac1_obj_qc_clusters.RData")
message("Calculating RNA activity atac3")
atac1[["RNA"]] <- CreateAssayObject(counts = GeneActivity(atac1))
atac1 <- NormalizeData(
    object = atac1,
    assay = "RNA",
    normalization.method = "LogNormalize",
    scale.factor = median(atac1$nCount_RNA)
)
saveRDS(atac1, file = "data/scATAC/atac1_obj_qc_clusters_calculated_RNA.rds")

message("Loading Seurat object")
load(file = "data/scATAC/atac2_heavy_filtering_obj_qc_clusters.RData")
plan("multiprocess", workers = 11)
message("Calculating RNA activity")
atac2_heavy_filtering[["RNA"]] <- CreateAssayObject(counts = GeneActivity(atac2_heavy_filtering))
atac2_heavy_filtering <- NormalizeData(
    object = atac2_heavy_filtering,
    assay = "RNA",
    normalization.method = "LogNormalize",
    scale.factor = median(atac2_heavy_filtering$nCount_RNA)
)
saveRDS(atac2_heavy_filtering, file = "data/scATAC/atac2_obj_qc_clusters_calculated_RNA.rds")

message("Loading Seurat object")
load(file = "data/scATAC/atac3_obj_qc_clusters.RData")
message("Calculating RNA activity atac3")
atac3[["RNA"]] <- CreateAssayObject(counts = GeneActivity(atac3))
atac3 <- NormalizeData(
    object = atac3,
    assay = "RNA",
    normalization.method = "LogNormalize",
    scale.factor = median(atac3$nCount_RNA)
)
saveRDS(atac3, file = "data/scATAC/atac3_obj_qc_clusters_calculated_RNA.rds")

message("Loading Seurat object")
load(file = "data/scATAC/atac4_heavy_filtering_obj_qc_clusters.RData")
message("Calculating RNA activity atac4")
atac4_heavy_filtering[["RNA"]] <- CreateAssayObject(counts = GeneActivity(atac4_heavy_filtering))
atac4_heavy_filtering <- NormalizeData(
    object = atac4_heavy_filtering,
    assay = "RNA",
    normalization.method = "LogNormalize",
    scale.factor = median(atac4_heavy_filtering$nCount_RNA)
)
saveRDS(atac4_heavy_filtering, file = "data/scATAC/atac4_obj_qc_clusters_calculated_RNA.rds")