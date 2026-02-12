#### 01A. make background file 
conda activate /anvil/scratch/x-rwang22/envs/bedtools

dmrbackground() {
  input=/anvil/projects/x-mcb130189/Wubin/BG/pseudobulk/DMR/Subclass
  scripts=/anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc
  type=$1
  cd /anvil/projects/x-mcb130189/rwang22/bican/ldsc/annot/${type}

  # BACKGROUND (no glut)
  touch _BACKGROUND_noGlut.bed
  for ct in Neuron Nonneuron; do
    echo "${ct}"
    for file in ${input}/${ct}/bed/*.${type}.dmr.bed; do
      filename=$(basename ${file})
      echo "Processing ${filename}"
      if [ "$filename" != "Glut.${type}.dmr.bed" ]; then
        cat ${file} | sed '/^#/d' >> _BACKGROUND_noGlut.bed
      fi   
    done
  done

  sort -k1,1 -k2,2n _BACKGROUND_noGlut.bed | bedtools merge -i - > _BACKGROUND_noGlut.merged.bed
  sbatch ${scripts}/01.make_annot.sh BACKGROUND_noGlut.merged.bed ${type} /anvil/projects/x-mcb130189/rwang22/bican/ldsc/annot/${type}/_BACKGROUND_noGlut.merged.bed

}

dmrbackground hypo
dmrbackground hyper

# remake the hypo and hyper dmrs 
newdmrbackground() {
  input=/anvil/scratch/x-rwang22/bican/dmrs/delta_0.2
  scripts=/anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc
  type=$1
  y="${type#10.02_}"
  cd /anvil/projects/x-mcb130189/rwang22/bican/ldsc/annot/${type}

  # BACKGROUND (no glut)
  touch _BACKGROUND_noGlut.bed
  for file in ${input}/*.${y}.dmr.bed; do
    filename=$(basename ${file})
    echo "Processing ${filename}"
    if [ "$filename" != "Glut.${y}.dmr.full.tsv.${y}.dmr.bed" ]; then
      cat ${file} | sed '/^#/d' >> _BACKGROUND_noGlut.bed
    fi   
  done


  sort -k1,1 -k2,2n _BACKGROUND_noGlut.bed | bedtools merge -i - > _BACKGROUND_noGlut.merged.bed
  rm _BACKGROUND_noGlut.bed
  sbatch ${scripts}/01.make_annot.sh BACKGROUND_noGlut.merged.bed ${type} /anvil/projects/x-mcb130189/rwang22/bican/ldsc/annot/${type}/_BACKGROUND_noGlut.merged.bed

}

newdmrbackground 10.02_hypo
newdmrbackground 10.02_hyper

# cell type specific ldsc 
ctdmrbackground() {
  input=/anvil/projects/x-mcb130189/Wubin/BG/pseudobulk/DMR/Subclass
  scripts=/anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc
  type=$1
  cd /anvil/projects/x-mcb130189/rwang22/bican/ldsc/annot/${type}

  # BACKGROUND (no glut)
  touch _BACKGROUND_noGlut.bed
  y="${type#ct-}"
  for ct in Neuron Nonneuron; do
    echo "${ct}"
    for file in ${input}/${ct}/cell_type_specific_bed/*.${y}.dmr.bed; do
      filename=$(basename ${file})
      echo "Processing ${filename}"
      if [ "$filename" != "Glut.${type}.dmr.bed" ]; then
        cat ${file} | sed '/^#/d' >> _BACKGROUND_noGlut.bed
      fi   
    done
  done

  sort -k1,1 -k2,2n _BACKGROUND_noGlut.bed | bedtools merge -i - > _BACKGROUND_noGlut.merged.bed
  sbatch ${scripts}/01.make_annot.sh BACKGROUND_noGlut.merged.bed ${type} /anvil/projects/x-mcb130189/rwang22/bican/ldsc/annot/${type}/_BACKGROUND_noGlut.merged.bed

}

ctdmrbackground ct-hypo
ctdmrbackground ct-hyper


loopbackground() {
  input=/anvil/projects/x-mcb130189/rwang22/bican/ldsc/bed
  scripts=/anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc
  type=$1
  cd ${input}/${type}

  # BACKGROUND
  touch _BACKGROUND.bed

  for file in ${input}/${type}/*.loops.bed; do
    filename=$(basename ${file})
    echo "Processing ${filename}"
    cat ${file} | sed '/^#/d' >> _BACKGROUND.bed
  done

  sort -k1,1 -k2,2n _BACKGROUND.bed | bedtools merge -i - > _BACKGROUND.merged.bed
  sbatch ${scripts}/01.make_annot.sh BACKGROUND.merged.bed ${type}-loop ${input}/${type}/_BACKGROUND.merged.bed

}

loopbackground group
loopbackground subclass

# group - msn
msn=(STRd_D1_Matrix_MSN STRd_D2_Matrix_MSN STRd_D1_Striosome_MSN \
    STRd_D2_StrioMat_Hybrid_MSN STRd_D2_Striosome_MSN STRv_D1_MSN STR_D1D2_Hybrid_MSN \
    STRv_D1_NUDAP_MSN STRv_D2_MSN)

group_msn_background() {
  input=/anvil/scratch/x-rwang22/bican/dmrs/group/delta_0.2
  scripts=/anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc
  type=$1
  y="${type#group-}"
  echo "${y}"
  
  cd /anvil/projects/x-mcb130189/rwang22/bican/ldsc/annot/${type}

  # BACKGROUND (no glut)
  touch _BACKGROUND_msn.bed
  for file in ${input}/*.${y}.dmr.bed; do
    filename=$(basename ${file})
    for ct in "${msn[@]}"; do
      if [[ $filename == ${ct}* ]]; then
          echo "${filename}"
          cat ${file} | sed '/^#/d' >> _BACKGROUND_msn.bed
      fi
    done   
  done

  sort -k1,1 -k2,2n  _BACKGROUND_msn.bed | bedtools merge -i - >  _BACKGROUND_msn.merged.bed
  rm _BACKGROUND_msn.bed
  sbatch ${scripts}/01.make_annot.sh BACKGROUND_msn.merged.bed ${type} /anvil/projects/x-mcb130189/rwang22/bican/ldsc/annot/${type}/_BACKGROUND_msn.merged.bed

}

group_msn_background group-hyper
group_msn_background group-hypo


# msn 12.02
msn_background() {
  input=/anvil/projects/x-mcb130189/Wubin/BG/pseudobulk/DMR/MSN_Group/MSN/bed
  scripts=/anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc
  type=$1
  y="${type#msn-}"
  echo "${y}"
  
  cd /anvil/projects/x-mcb130189/rwang22/bican/ldsc/annot/${type}

  # BACKGROUND (no glut)
  touch _BACKGROUND_msn.bed
  for file in ${input}/*.${y}.dmr.bed; do
    filename=$(basename ${file})
    echo "${filename}"
    cat ${file} | sed '/^#/d' >> _BACKGROUND_msn.bed
  done

  sort -k1,1 -k2,2n  _BACKGROUND_msn.bed | bedtools merge -i - >  _BACKGROUND_msn.merged.bed
  rm _BACKGROUND_msn.bed
  sbatch ${scripts}/01.make_annot.sh BACKGROUND_msn.merged.bed ${type} /anvil/projects/x-mcb130189/rwang22/bican/ldsc/annot/${type}/_BACKGROUND_msn.merged.bed

}

msn_background msn-hyper
msn_background msn-hypo


# abc links - group
input=/anvil/projects/x-mcb130189/Wubin/BG/Browser/Tracks/Group/ABC.links
scripts=/anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc
type=abc-group

cd /anvil/projects/x-mcb130189/rwang22/bican/ldsc/annot/${type}
touch _BACKGROUND_abc.bed
for file in ${input}/*.bed; do
  filename=$(basename ${file})
  echo "${filename}"
  cat ${file} | sed '/^#/d' >> _BACKGROUND_abc.bed
done

sort -k1,1 -k2,2n  _BACKGROUND_abc.bed | bedtools merge -i - >  _BACKGROUND_abc.merged.bed
rm _BACKGROUND_abc.bed
sbatch ${scripts}/01.make_annot.sh BACKGROUND_abc.merged.bed ${type} /anvil/projects/x-mcb130189/rwang22/bican/ldsc/annot/${type}/_BACKGROUND_abc.merged.bed



# abc links - subclass
input=/anvil/projects/x-mcb130189/Wubin/BG/Browser/Tracks/Subclass/ABC.links
scripts=/anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc
type=abc-subclass

cd /anvil/projects/x-mcb130189/rwang22/bican/ldsc/annot/${type}
touch _BACKGROUND_abc.bed
for file in ${input}/*.bed; do
  filename=$(basename ${file})
  echo "${filename}"
  cat ${file} | sed '/^#/d' >> _BACKGROUND_abc.bed
done

sort -k1,1 -k2,2n  _BACKGROUND_abc.bed | bedtools merge -i - >  _BACKGROUND_abc.merged.bed
rm _BACKGROUND_abc.bed
sbatch ${scripts}/01.make_annot.sh BACKGROUND_abc.merged.bed ${type} /anvil/projects/x-mcb130189/rwang22/bican/ldsc/annot/${type}/_BACKGROUND_abc.merged.bed
