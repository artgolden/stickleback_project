conversion_table <- read.table(file = "data/stickleback_zebrafish_orthologs.tsv", sep = "\t", header = TRUE)
stickleback_to_zebrafish_IDs <- function(stickleback_ensembl_ids, conversion_table, id_type="zebrafish_ensembl"){
  conversion_table <- merge(data.frame(stickleback_ensembl = stickleback_ensembl_ids), conversion_table, by="stickleback_ensembl", sort=FALSE)
  zebrafish_ids <- conversion_table[,id_type]
  return(zebrafish_ids)
}