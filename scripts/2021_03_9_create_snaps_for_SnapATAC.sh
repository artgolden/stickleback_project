#!/bin/bash
# Script to convert fragments.tsv.gz scATAC files to snap object for SnapATAC pipeline
set -e
set -u
set -o pipefail
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

project_dir=$(dirname $DIR)
samples=("atac1" "atac2" "atac3" "atac4")
path="${project_dir}/data/scATAC/"

for sample in ${samples[*]}; do
    cd ${path}${sample}
    if [ -f "${sample}.snap" ]; then
        echo "${sample}.snap exists, moving to next sample"
        continue
    fi
    echo "processing ${sample} in ${path}${sample}/" &&
    fragments="fragments" &&
    echo "decompressing fragments.tsv.gz" &&
    unpigz -k fragments.tsv.gz &&
    echo "generating fragments.bed" &&
    sort -k4,4 fragments.tsv > fragments.bed &&
    echo "compressing fragments.bed" &&
    pigz fragments.bed  &&
    echo "creating snap object" &&
    snaptools snap-pre \
	--input-file=fragments.bed.gz \
	--output-snap=${sample}.snap \
	--genome-name=gasAcu1 \
	--genome-size=../../gasAcu1_reference/gasAcu1.chrom.sizes \
	--min-mapq=30 \
	--min-flen=50 \
	--max-flen=1000 \
	--keep-chrm=TRUE \
	--keep-single=FALSE \
	--keep-secondary=False \
	--overwrite=True \
	--max-num=20000 \
	--min-cov=500 \
	--verbose=True &&
    echo "created ${sample}.snap successfully" &&
    rm fragments.tsv fragments.bed.gz

done