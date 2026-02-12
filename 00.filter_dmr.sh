
# subclass hyper and hypo DMRs
OUTDIR=/anvil/scratch/x-rwang22/bican/dmrs/delta_0.2
INDIR=/anvil/projects/x-mcb130189/Wubin/BG/pseudobulk/DMR/Subclass
ref=/anvil/projects/x-mcb130189/rwang22/references/hg38

# expand 250 bp upstream or downstream 
# delta > 0.2 
for mC in hypo hyper; do
    for ct in Neuron Nonneuron; do
    echo "${ct}"
        for file in ${INDIR}/${ct}/bed/*.${mC}.dmr.full.tsv; do
            filename=$(basename ${file})
            echo "Processing ${filename}"
            awk 'BEGIN{OFS="\t"; FS="\t"} NR > 1 && $5 > 0.2 {print $1, $2, $3}' ${file} | \
                bedtools slop -i - -b 250 -g ${ref}/hg38.chrom.sizes | \
                sort -k1,1 -k2,2n |bedtools merge -i - > ${OUTDIR}/${filename}.${mC}.dmr.bed
        done
    done
done


# group hyper and hypo DMRs
OUTDIR=/anvil/scratch/x-rwang22/bican/dmrs/group/delta_0.2
INDIR=/anvil/projects/x-mcb130189/Wubin/BG/pseudobulk/DMR/Group
ref=/anvil/projects/x-mcb130189/rwang22/references/hg38

# expand 250 bp upstream or downstream 
# delta > 0.2 
for mC in hypo hyper; do
    echo "${ct}"
    for file in ${INDIR}/*/bed/*.${mC}.dmr.full.tsv; do
        filename=$(basename ${file})
        echo "Processing ${filename}"
        awk 'BEGIN{OFS="\t"; FS="\t"} NR > 1 && $5 > 0.2 {print $1, $2, $3}' ${file} | \
            bedtools slop -i - -b 250 -g ${ref}/hg38.chrom.sizes | \
            sort -k1,1 -k2,2n |bedtools merge -i - > ${OUTDIR}/${filename}.${mC}.dmr.bed
    done
done
