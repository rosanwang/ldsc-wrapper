# GROUP
BASEDIR=/anvil/projects/x-mcb130189/Wubin/BG/HIC/BG_Group/Group_loop
OUTDIR=/anvil/projects/x-mcb130189/rwang22/bican/ldsc/bed/group
cts=($(find ${BASEDIR} -mindepth 1 -maxdepth 1 -type d -printf "%f\n")) 

for ct in "${cts[@]}"; do
    input=${BASEDIR}/${ct}/${ct}/${ct}.loop.bedpe 
    awk 'BEGIN{OFS="\t"} {print $1, $2, $3; print $4, $5, $6}' ${input} > ${OUTDIR}/${ct}.loops.bed
done

# SUBCLASS
BASEDIR=/anvil/projects/x-mcb130189/Wubin/BG/HIC/BG_Subclass/Subclass_loop
OUTDIR=/anvil/projects/x-mcb130189/rwang22/bican/ldsc/bed/subclass
cts=($(find ${BASEDIR} -mindepth 1 -maxdepth 1 -type d -printf "%f\n")) 

for ct in "${cts[@]}"; do
    input=${BASEDIR}/${ct}/${ct}/${ct}.loop.bedpe 
    awk 'BEGIN{OFS="\t"} {print $1, $2, $3; print $4, $5, $6}' ${input} > ${OUTDIR}/${ct}.loops.bed
done