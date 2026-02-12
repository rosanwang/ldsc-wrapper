
############## 02. make the input cell type file 
dmrldcts() {
    list=$1
    type=$2

    OUTDIR=/anvil/projects/x-mcb130189/rwang22/bican/ldsc/ldscore
    input=/anvil/projects/x-mcb130189/Wubin/BG/pseudobulk/DMR/Subclass 

    touch ${list}
    for n in Neuron Nonneuron; do
        for file in ${input}/${n}/bed/*.${type}.dmr.bed; do
            filename=$(basename ${file})
            ct=${filename%.${type}.dmr.bed}

            if [ "$ct" != "Glut" ]; then
                file=${OUTDIR}/${type}/${filename}.
                background=${OUTDIR}/${type}/BACKGROUND_noGlut.merged.bed.
                echo -e "${ct}\t${file},${background}" >> ${list}
            fi
        done
    done
}

dmrldcts hypo_DMRs.09.19.ldcts hypo
dmrldcts hyper_DMRs.09.19.ldcts hyper

dmrldcts hypo_DMRs.09.26.ldcts hypo
dmrldcts hyper_DMRs.09.26.ldcts hyper

ctdmrldcts() {
    list=$1
    type=$2

    OUTDIR=/anvil/projects/x-mcb130189/rwang22/bican/ldsc/ldscore
    input=/anvil/projects/x-mcb130189/Wubin/BG/pseudobulk/DMR/Subclass 
    y="${type#ct-}"
    touch ${list}
    for n in Neuron Nonneuron; do
        for file in ${input}/${n}/cell_type_specific_bed/*.${y}.dmr.bed; do
            filename=$(basename ${file})
            ct=${filename%.${y}.dmr.bed}

            if [ "$ct" != "Glut" ]; then
                file=${OUTDIR}/${type}/${filename}.
                background=${OUTDIR}/${type}/BACKGROUND_noGlut.merged.bed.
                echo -e "${ct}\t${file},${background}" >> ${list}
            fi
        done
    done
}

ctdmrldcts ct-hypo_DMRs.09.26.ldcts ct-hypo
ctdmrldcts ct-hyper_DMRs.09.26.ldcts ct-hyper

loopldcts() {
    list=$1
    type=$2

    OUTDIR=/anvil/projects/x-mcb130189/rwang22/bican/ldsc/ldscore
    input=/anvil/projects/x-mcb130189/rwang22/bican/ldsc/bed
    touch ${list}
    for file in ${input}/${type}/*.loops.bed; do
        filename=$(basename ${file})
        ct=${filename%.loops.bed}

        file=${OUTDIR}/${type}-loop/${filename}.
        background=${OUTDIR}/${type}-loop/BACKGROUND.merged.bed.
        echo -e "${ct}\t${file},${background}" >> ${list}
    done
}

loopldcts group_loops.09.19.ldcts group
loopldcts subclass_loops.09.19.ldcts subclass

newldcts() {
    list=$1
    type=$2

    OUTDIR=/anvil/projects/x-mcb130189/rwang22/bican/ldsc/ldscore
    input=/anvil/scratch/x-rwang22/bican/dmrs/delta_0.2
    y="${type#10.02_}"

    touch ${list}
    for file in ${input}/*.${y}.dmr.bed; do
        filename=$(basename ${file})
        ct=${filename%.${y}.dmr.full.tsv.${y}.dmr.bed}
        if [ "$ct" != "Glut" ]; then
            file=${OUTDIR}/${type}/${filename}.
            background=${OUTDIR}/${type}/BACKGROUND_noGlut.merged.bed.
            echo -e "${ct}\t${file},${background}" >> ${list}
        fi

    done
}

newldcts hyper.10.02.ldcts 10.02_hyper
newldcts hypo.10.02.ldcts 10.02_hypo

# group ldcts 
msn=(STRd_D1_Matrix_MSN STRd_D2_Matrix_MSN STRd_D1_Striosome_MSN \
    STRd_D2_StrioMat_Hybrid_MSN STRd_D2_Striosome_MSN STRv_D1_MSN STR_D1D2_Hybrid_MSN \
    STRv_D1_NUDAP_MSN STRv_D2_MSN)

groupldcts() {
    list=$1
    type=$2

    OUTDIR=/anvil/projects/x-mcb130189/rwang22/bican/ldsc/ldscore
    input=/anvil/scratch/x-rwang22/bican/dmrs/group/delta_0.2
    y="${type#group-}"

    touch ${list}
    for file in ${input}/*${y}.dmr.bed; do
        filename=$(basename ${file})
        ct=${filename%.${y}.dmr.full.tsv.${y}.dmr.bed}
        for t in "${msn[@]}"; do
            if [[ $filename == ${t}* ]]; then
                path=${OUTDIR}/${type}/${filename}.
                background=${OUTDIR}/${type}/BACKGROUND_msn.merged.bed.
                echo -e "${ct}\t${path},${background}" >> ${list}
            fi
        done
    done

}

groupldcts group.msn.hyper.10.14.ldcts group-hyper
groupldcts group.msn.hypo.10.14.ldcts group-hypo


# 12.02 msn ldscts 
msnldcts() {
    list=$1
    type=$2

    OUTDIR=/anvil/projects/x-mcb130189/rwang22/bican/ldsc/ldscore
    input=/anvil/projects/x-mcb130189/Wubin/BG/pseudobulk/DMR/MSN_Group/MSN/bed
    y="${type#msn-}"
    touch ${list}

    for file in ${input}/*.${y}.dmr.bed; do
        filename=$(basename ${file})
        ct=${filename%.${y}.dmr.bed}

        file=${OUTDIR}/${type}/${filename}.
        background=${OUTDIR}/${type}/BACKGROUND_msn.merged.bed.
        echo -e "${ct}\t${file},${background}" >> ${list}

    done

}

msnldcts msn.hyper.12.02.ldcts msn-hyper
msnldcts msn.hypo.12.02.ldcts msn-hypo

# abc subclass 
list=abc-subclass.12.23.ldcts 
type=abc-subclass

OUTDIR=/anvil/projects/x-mcb130189/rwang22/bican/ldsc/ldscore
input=/anvil/projects/x-mcb130189/Wubin/BG/Browser/Tracks/Subclass/ABC.links

touch ${list}
for file in ${input}/*.bed; do
    filename=$(basename ${file})
    ct=${filename%.bed}

    file=${OUTDIR}/${type}/${filename}.
    background=${OUTDIR}/${type}/BACKGROUND_abc.merged.bed.
    echo -e "${ct}\t${file},${background}" >> ${list}
done

# abc group 
list=abc-group.12.23.ldcts 
type=abc-group

OUTDIR=/anvil/projects/x-mcb130189/rwang22/bican/ldsc/ldscore
input=/anvil/projects/x-mcb130189/Wubin/BG/Browser/Tracks/Group/ABC.links

touch ${list}
for file in ${input}/*.bed; do
    filename=$(basename ${file})
    ct=${filename%.bed}

    file=${OUTDIR}/${type}/${filename}.
    background=${OUTDIR}/${type}/BACKGROUND_abc.merged.bed.
    echo -e "${ct}\t${file},${background}" >> ${list}
done

############## 03. run ldsc
cd /anvil/projects/x-mcb130189/rwang22/bican/ldsc

bash /anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc/03.run_ldsc.sh hypo_DMRs.09.19.ldcts
bash /anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc/03.run_ldsc.sh hyper_DMRs.09.19.ldcts
bash /anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc/03.run_ldsc.sh subclass_loops.09.19.ldcts
bash /anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc/03.run_ldsc.sh group_loops.09.19.ldcts

bash /anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc/03.run_ldsc.sh hypo_DMRs.09.26.ldcts 
bash /anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc/03.run_ldsc.sh hyper_DMRs.09.26.ldcts

bash /anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc/03.run_ldsc.sh ct-hyper_DMRs.09.26.ldcts
bash /anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc/03.run_ldsc.sh ct-hypo_DMRs.09.26.ldcts

bash /anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc/03.run_ldsc.sh hypo.10.02.ldcts
bash /anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc/03.run_ldsc.sh hyper.10.02.ldcts

bash /anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc/03.run_ldsc.sh group.msn.hypo.10.14.ldcts
bash /anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc/03.run_ldsc.sh group.msn.hyper.10.14.ldcts

bash /anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc/03.run_ldsc.sh msn.hyper.12.02.ldcts
bash /anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc/03.run_ldsc.sh msn.hypo.12.02.ldcts

bash /anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc/03.run_ldsc.sh abc-group.12.23.ldcts
bash /anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc/03.run_ldsc.sh abc-subclass.12.23.ldcts