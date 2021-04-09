#!/bin/bash

rsync -avzhP --ignore-existing apolozhintsev@10.30.16.111:/gss/apolozhintsev/fish_atac/outs/without_bam/sticleback_atac_2_ATAC1/outs/fragments.tsv.gz  \
:/gss/apolozhintsev/fish_atac/outs/without_bam/sticleback_atac_2_ATAC1/outs/filtered_peak_bc_matrix.h5 \
:/gss/apolozhintsev/fish_atac/outs/without_bam/sticleback_atac_2_ATAC1/outs/singlecell.csv \
:/gss/apolozhintsev/fish_atac/outs/without_bam/sticleback_atac_2_ATAC1/outs/fragments.tsv.gz.tbi \
:/gss/apolozhintsev/fish_atac/outs/without_bam/sticleback_atac_2_ATAC1/outs/peaks.bed \
/home/tema/work/skolkovo/fish_project/data/scATAC/atac1/

rsync -avzhP --ignore-existing apolozhintsev@10.30.16.111:/gss/apolozhintsev/fish_atac/outs/without_bam/sticleback_atac_2_ATAC2/outs/fragments.tsv.gz  \
:/gss/apolozhintsev/fish_atac/outs/without_bam/sticleback_atac_2_ATAC2/outs/filtered_peak_bc_matrix.h5 \
:/gss/apolozhintsev/fish_atac/outs/without_bam/sticleback_atac_2_ATAC2/outs/singlecell.csv \
:/gss/apolozhintsev/fish_atac/outs/without_bam/sticleback_atac_2_ATAC2/outs/fragments.tsv.gz.tbi \
:/gss/apolozhintsev/fish_atac/outs/without_bam/sticleback_atac_2_ATAC2/outs/peaks.bed \
/home/tema/work/skolkovo/fish_project/data/scATAC/atac2/

rsync -avzhP --ignore-existing apolozhintsev@10.30.16.111:/gss/apolozhintsev/fish_atac/outs/without_bam/sticleback_atac_2_ATAC3/outs/fragments.tsv.gz  \
:/gss/apolozhintsev/fish_atac/outs/without_bam/sticleback_atac_2_ATAC3/outs/filtered_peak_bc_matrix.h5 \
:/gss/apolozhintsev/fish_atac/outs/without_bam/sticleback_atac_2_ATAC3/outs/singlecell.csv \
:/gss/apolozhintsev/fish_atac/outs/without_bam/sticleback_atac_2_ATAC3/outs/fragments.tsv.gz.tbi \
:/gss/apolozhintsev/fish_atac/outs/without_bam/sticleback_atac_2_ATAC3/outs/peaks.bed \
/home/tema/work/skolkovo/fish_project/data/scATAC/atac3/

rsync -avzhP --ignore-existing apolozhintsev@10.30.16.111:/gss/apolozhintsev/fish_atac/outs/without_bam/sticleback_atac_2_ATAC4/outs/fragments.tsv.gz  \
:/gss/apolozhintsev/fish_atac/outs/without_bam/sticleback_atac_2_ATAC4/outs/filtered_peak_bc_matrix.h5 \
:/gss/apolozhintsev/fish_atac/outs/without_bam/sticleback_atac_2_ATAC4/outs/singlecell.csv \
:/gss/apolozhintsev/fish_atac/outs/without_bam/sticleback_atac_2_ATAC4/outs/fragments.tsv.gz.tbi \
:/gss/apolozhintsev/fish_atac/outs/without_bam/sticleback_atac_2_ATAC4/outs/peaks.bed \
/home/tema/work/skolkovo/fish_project/data/scATAC/atac4/


