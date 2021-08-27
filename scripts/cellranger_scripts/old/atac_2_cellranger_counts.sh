#!/bin/bash
#PBS -N cellranger_make_counts_ATAC4 
#PBS -l walltime=1:10:10:00
#PBS -l nodes=1:ppn=16
#PBS -l mem=100gb
#PBS -d .
/home/apolozhintsev/bin/cellranger-atac-1.2.0/cellranger-atac count --id=sticleback_atac_2_ATAC4 \
--fastqs=/home/apolozhintsev/fish_atac/sticleback_atac/outs/fastq_path/HHLKLBCX3/ATAC4/ \
--reference=/gss/khrameeva/soft/refdata-cellranger-stickleback/ga-atac/ \
--localcores=16 2>&1>> /home/apolozhintsev/fish_atac/atac_2_make_counts_ATAC4.log
