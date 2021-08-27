#!/bin/bash
#PBS -N cellranger_make_counts_ATAC1
#PBS -l walltime=0:12:10:00
#PBS -l nodes=1:ppn=16
#PBS -l mem=100gb
#PBS -d /gss/apolozhintsev/fish_atac/outs/
/home/apolozhintsev/bin/cellranger-atac-1.2.0/cellranger-atac count --id=ATAC1_counts \
--fastqs=/gss/apolozhintsev/fish_atac/outs/stickleback_atac/outs/fastq_path/HHLKLBCX3/ATAC1/ \
--reference=/gss/khrameeva/soft/refdata-cellranger-stickleback/ga-atac/ \
--localcores=16 2>&1>> /gss/apolozhintsev/fish_atac/log/ATAC1_cellranger_counts.log
