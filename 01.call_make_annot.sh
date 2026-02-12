scripts=/anvil/projects/x-mcb130189/rwang22/bican/scripts/ldsc

## NOTE
# make the directories for each run in ldscore and annot 

# 09.19 hypo DMRs
input=/anvil/projects/x-mcb130189/Wubin/BG/pseudobulk/DMR/Subclass

for ct in Neuron Nonneuron; do
  echo "${ct}"
  for file in ${input}/${ct}/bed/*.hypo.dmr.bed; do
    filename=$(basename ${file})
    echo "Processing ${filename}"
    sbatch ${scripts}/01.make_annot.sh ${filename} __09.19_hypo ${file}
  done
done

# 09.19 hyper DMRs
input=/anvil/projects/x-mcb130189/Wubin/BG/pseudobulk/DMR/Subclass

for ct in Neuron Nonneuron; do
  echo "${ct}"
  for file in ${input}/${ct}/bed/*.hyper.dmr.bed; do
    filename=$(basename ${file})
    echo "Processing ${filename}"
    sbatch ${scripts}/01.make_annot.sh ${filename} __09.19_hyper ${file}
  done
done

# 09.26 hypo DMRs
input=/anvil/projects/x-mcb130189/Wubin/BG/pseudobulk/DMR/Subclass

for ct in Neuron Nonneuron; do
  echo "${ct}"
  for file in ${input}/${ct}/bed/*.hypo.dmr.bed; do
    filename=$(basename ${file})
    echo "Processing ${filename}"
    sbatch ${scripts}/01.make_annot.sh ${filename} hypo ${file}
  done
done

# 09.26 hyper DMRs
input=/anvil/projects/x-mcb130189/Wubin/BG/pseudobulk/DMR/Subclass

for ct in Neuron Nonneuron; do
  echo "${ct}"
  for file in ${input}/${ct}/bed/*.hyper.dmr.bed; do
    filename=$(basename ${file})
    echo "Processing ${filename}"
    sbatch ${scripts}/01.make_annot.sh ${filename} hyper ${file}
  done
done

# 10.02 hypo DMRs
input=/anvil/scratch/x-rwang22/bican/dmrs/delta_0.2
for file in ${input}/*.hypo.dmr.bed; do
  filename=$(basename ${file})
  echo "Processing ${filename}"
  sbatch ${scripts}/01.make_annot.sh ${filename} 10.02_hypo ${file}
done

# 10.02 hyper DMRs
input=/anvil/scratch/x-rwang22/bican/dmrs/delta_0.2
for file in ${input}/*.hyper.dmr.bed; do
  filename=$(basename ${file})
  echo "Processing ${filename}"
  sbatch ${scripts}/01.make_annot.sh ${filename} 10.02_hyper ${file}
done



# cell type specific hypo DMR 
input=/anvil/projects/x-mcb130189/Wubin/BG/pseudobulk/DMR/Subclass

for ct in Neuron Nonneuron; do
  echo "${ct}"
  for file in ${input}/${ct}/cell_type_specific_bed/*.hypo.dmr.bed; do
    filename=$(basename ${file})
    echo "Processing ${filename}"
    sbatch ${scripts}/01.make_annot.sh ${filename} ct-hypo ${file}
  done
done

# cell type specific hyper DMR
input=/anvil/projects/x-mcb130189/Wubin/BG/pseudobulk/DMR/Subclass

for ct in Neuron Nonneuron; do
  echo "${ct}"
  for file in ${input}/${ct}/cell_type_specific_bed/*.hyper.dmr.bed; do
    filename=$(basename ${file})
    echo "Processing ${filename}"
    sbatch ${scripts}/01.make_annot.sh ${filename} ct-hyper ${file}
  done
done

# group loops 
input=/anvil/projects/x-mcb130189/rwang22/bican/ldsc/bed

for file in ${input}/group/*.bed; do
  filename=$(basename ${file})
  echo "Processing ${filename}"
  sbatch ${scripts}/01.make_annot.sh ${filename} group-loop ${file}

done

# subclass loops 
input=/anvil/projects/x-mcb130189/rwang22/bican/ldsc/bed

for file in ${input}/subclass/*.bed; do
  filename=$(basename ${file})
  echo "Processing ${filename}"
  sbatch ${scripts}/01.make_annot.sh ${filename} subclass-loop ${file}
done

# group hyper DMR 
input=/anvil/scratch/x-rwang22/bican/dmrs/group/delta_0.2

for file in ${input}/*hyper.dmr.bed; do
  filename=$(basename ${file})
  echo "Processing ${filename}"
  sbatch ${scripts}/01.make_annot.sh ${filename} group-hyper ${file}
done

# group hypo DMR 
input=/anvil/scratch/x-rwang22/bican/dmrs/group/delta_0.2

for file in ${input}/*hypo.dmr.bed; do
  filename=$(basename ${file})
  echo "Processing ${filename}"
  sbatch ${scripts}/01.make_annot.sh ${filename} group-hypo ${file}
done

# 12.01 hypo MSN DMRs
input=/anvil/projects/x-mcb130189/Wubin/BG/pseudobulk/DMR/MSN_Group/MSN/bed

for file in ${input}/*hypo.dmr.bed; do
  filename=$(basename ${file})
  echo "Processing ${filename}"
  sbatch ${scripts}/01.make_annot.sh ${filename} msn-hypo ${file}
done

# 12.01 hyper MSN DMRs
input=/anvil/projects/x-mcb130189/Wubin/BG/pseudobulk/DMR/MSN_Group/MSN/bed

for file in ${input}/*hyper.dmr.bed; do
  filename=$(basename ${file})
  echo "Processing ${filename}"
  sbatch ${scripts}/01.make_annot.sh ${filename} msn-hyper ${file}
done

# Subclass: /anvil/projects/x-mcb130189/Wubin/BG/Browser/Tracks/Subclass/ABC.links/*.bed
# Group: /anvil/projects/x-mcb130189/Wubin/BG/Browser/Tracks/Group/ABC.links/*.bed
# cell type enhancers -- Subclass
input=/anvil/projects/x-mcb130189/Wubin/BG/Browser/Tracks/Subclass/ABC.links

for file in ${input}/*.bed; do
  filename=$(basename ${file})
  echo "Processing ${filename}"
  sbatch ${scripts}/01.make_annot.sh ${filename} abc-subclass ${file}
done


# cell type enhancers -- Group
input=/anvil/projects/x-mcb130189/Wubin/BG/Browser/Tracks/Group/ABC.links

for file in ${input}/*.bed; do
  filename=$(basename ${file})
  echo "Processing ${filename}"
  sbatch ${scripts}/01.make_annot.sh ${filename} abc-group ${file}
done