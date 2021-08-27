library(fastqcr)
for (i in c("1", "2", "3", "4")){
	fastqc(fq.dir = paste0("/home/apolozhintsev/fish_atac/sticleback_atac/outs/fastq_path/HHLKLBCX3/ATAC", i, "/"),
	qc.dir = "/home/apolozhintsev/fish_atac/atac_2_fastqc_results/",
	threads = 30)
}
