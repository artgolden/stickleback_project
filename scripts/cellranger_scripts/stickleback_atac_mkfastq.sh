#!/bin/bash
#PBS -N stickleback_scATAC_mkfastq
#PBS -l walltime=0:06:10:00
#PBS -l nodes=1:ppn=16
#PBS -l mem=64gb
#PBS -d /gss/apolozhintsev/fish_atac/outs/
/home/apolozhintsev/bin/cellranger-atac-1.2.0/cellranger-atac mkfastq --id=stickleback_atac \
--run=../data/bcl/201023_HSGA.Stickleback_ATACSeq_SingleCell.ATAC1-4.raw \
--csv=../data/stickleback_atac_sample_sheet_simple_for_mkfastq.csv \
--localcores=16 2>&1>> ../log/mkfastq_sticleback_atac.log
