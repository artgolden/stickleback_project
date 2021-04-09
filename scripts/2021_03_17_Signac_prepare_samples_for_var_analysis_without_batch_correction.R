
library(Signac)
library(Seurat)
library(GenomicRanges)
library(future)

plan("multiprocess", workers = 6)
options(future.globals.maxSize = 28000 * 1024^2) # for 28 Gb RAM

# read in peak sets
peaks_atac1 <- read.table(
  file = "../data/scATAC/atac1/peaks.bed",
  col.names = c("chr", "start", "end")
)
peaks_atac2 <- read.table(
  file = "../data/scATAC/atac2/peaks.bed",
  col.names = c("chr", "start", "end")
)
peaks_atac3 <- read.table(
  file = "../data/scATAC/atac3/peaks.bed",
  col.names = c("chr", "start", "end")
)
peaks_atac4 <- read.table(
  file = "../data/scATAC/atac4/peaks.bed",
  col.names = c("chr", "start", "end")
)

# convert to genomic ranges
gr_atac1 <- makeGRangesFromDataFrame(peaks_atac1)
gr_atac2 <- makeGRangesFromDataFrame(peaks_atac2)
gr_atac3 <- makeGRangesFromDataFrame(peaks_atac3)
gr_atac4 <- makeGRangesFromDataFrame(peaks_atac4)

# Create a unified set of peaks to quantify in each dataset
combined_peaks <- reduce(x = c(gr_atac1, gr_atac2, gr_atac3, gr_atac4))

# Filter out bad peaks based on length
peakwidths <- width(combined_peaks)
combined_peaks <- combined_peaks[peakwidths  < 10000 & peakwidths > 20]
combined_peaks

# load metadata
md_atac1 <- read.table(
  file = "../data/scATAC/atac1/singlecell.csv",
  stringsAsFactors = FALSE,
  sep = ",",
  header = TRUE,
  row.names = 1
)[-1, ] # remove the first row

md_atac2 <- read.table(
  file = "../data/scATAC/atac2/singlecell.csv",
  stringsAsFactors = FALSE,
  sep = ",",
  header = TRUE,
  row.names = 1
)[-1, ] # remove the first row

md_atac3 <- read.table(
  file = "../data/scATAC/atac3/singlecell.csv",
  stringsAsFactors = FALSE,
  sep = ",",
  header = TRUE,
  row.names = 1
)[-1, ] # remove the first row

md_atac4 <- read.table(
  file = "../data/scATAC/atac4/singlecell.csv",
  stringsAsFactors = FALSE,
  sep = ",",
  header = TRUE,
  row.names = 1
)[-1, ] # remove the first row


# perform an initial filtering of low count cells
md_atac1 <- md_atac1[md_atac1$passed_filters > 500, ] # I have tested and it leaves around 10k barcodes for atac1, 40-50k for others
md_atac2 <- md_atac2[md_atac2$passed_filters > 500, ]
md_atac3 <- md_atac3[md_atac3$passed_filters > 500, ]
md_atac4 <- md_atac4[md_atac4$passed_filters > 500, ] 

# create fragment objects
frags_atac1 <- CreateFragmentObject(
  path = "../data/scATAC/atac1/fragments.tsv.gz",
  cells = rownames(md_atac1)
)

frags_atac2 <- CreateFragmentObject(
  path = "../data/scATAC/atac2/fragments.tsv.gz",
  cells = rownames(md_atac2)
)

frags_atac3 <- CreateFragmentObject(
  path = "../data/scATAC/atac3/fragments.tsv.gz",
  cells = rownames(md_atac3)
)

frags_atac4 <- CreateFragmentObject(
  path = "../data/scATAC/atac4/fragments.tsv.gz",
  cells = rownames(md_atac4)
)

## Quantify peaks in each dataset

atac1_counts <- FeatureMatrix(
  fragments = frags_atac1,
  features = combined_peaks,
  cells = rownames(md_atac1)
)

atac2_counts <- FeatureMatrix(
  fragments = frags_atac2,
  features = combined_peaks,
  cells = rownames(md_atac2)
)

atac3_counts <- FeatureMatrix(
  fragments = frags_atac3,
  features = combined_peaks,
  cells = rownames(md_atac3)
)

atac4_counts <- FeatureMatrix(
  fragments = frags_atac4,
  features = combined_peaks,
  cells = rownames(md_atac4)
)

## Get filtered cell IDs for each sample (Filtering done previously in separate notebooks)
load("../data/scATAC/atac1_obj_qc_clusters.RData")
filtered_cells_atac1 <- Cells(atac1)
load("../data/scATAC/atac2_heavy_filtering_obj_qc_clusters.RData")
filtered_cells_atac2 <- Cells(atac2_heavy_filtering)
load("../data/scATAC/atac3_obj_qc_clusters.RData")
filtered_cells_atac3 <- Cells(atac3)
load("../data/scATAC/atac4_heavy_filtering_obj_qc_clusters.RData")
filtered_cells_atac4 <- Cells(atac4_heavy_filtering)


## Create the objects and filter cells

atac1_assay <- CreateChromatinAssay(atac1_counts, fragments = frags_atac1)
atac1 <- CreateSeuratObject(atac1_assay, assay = "ATAC")
atac1 <- subset(
  x = atac1,
  cells = filtered_cells_atac1
)

atac2_assay <- CreateChromatinAssay(atac2_counts, fragments = frags_atac2)
atac2 <- CreateSeuratObject(atac2_assay, assay = "ATAC")
atac2 <- subset(
  x = atac2,
  cells = filtered_cells_atac2
)

atac3_assay <- CreateChromatinAssay(atac3_counts, fragments = frags_atac3)
atac3 <- CreateSeuratObject(atac3_assay, assay = "ATAC")
atac3 <- subset(
  x = atac3,
  cells = filtered_cells_atac3
)

atac4_assay <- CreateChromatinAssay(atac4_counts, fragments = frags_atac4)
atac4 <- CreateSeuratObject(atac4_assay, assay = "ATAC")
atac4 <- subset(
  x = atac4,
  cells = filtered_cells_atac4
)

## Merge objects

# add information to identify sample of origin
atac1$sample <- "atac1"
atac2$sample <- "atac2"
atac3$sample <- "atac3"
atac4$sample <- "atac4"

# merge all samples, adding a cell ID to make sure cell names are unique
combined <- merge(
  x = atac1,
  y = list(atac2, atac3, atac4),
  add.cell.ids = c("atac1", "atac2", "atac3", "atac4")
)
combined[["ATAC"]]

combined <- RunTFIDF(combined)
combined <- FindTopFeatures(combined, min.cutoff = 20)
combined <- RunSVD(combined)
combined <- RunUMAP(combined, dims = 2:40, reduction = "lsi")

save(combined, file = "../data/scATAC/combined_scATAC_samples_obj.RData")

