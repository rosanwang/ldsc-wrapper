source ~/miniconda3/etc/profile.d/conda.sh
conda activate /anvil/projects/x-mcb130189/rwang22/conda_envs/ldsc

external=/anvil/projects/x-mcb130189/rwang22/bican/ref/GRCh38
ldsc=/home/x-rwang22/ldsc

cts_name=$1 # DMRs.07.23

#### 3. partition heritability 
GWAS=/anvil/scratch/x-rwang22/bican/ref/ldsc

output=/anvil/projects/x-mcb130189/rwang22/bican/ldsc/output/${cts_name}

[ -d "$output" ] || mkdir $output

for trait in $GWAS/*.sumstats.gz; do
    filename=$(basename "$trait")
    basename="${filename%.sumstats.gz}"
    echo "Processing $basename"
    sbatch -p shared --mem=50g --time=02:00:00 --nodes=1 --error=%x_%j.err --wrap="python $ldsc/ldsc.py --h2-cts ${trait} --ref-ld-chr $external/baselineLD_v2.2/baselineLD. --out ${output}/${basename}_${cts_name} --ref-ld-chr-cts $cts_name --w-ld-chr $external/weights/weights.hm3_noMHC."
done

    # submit job for ldsc 
    # my old command
    # python $ldsc/ldsc.py --h2-cts $file --ref-ld-chr $external/baselineLD_v2.2/baselineLD. --overlap-annot --frqfile-chr $external/$genome/plink_files/1000G.EUR.hg38. --print-coefficients --out $basename  --w-ld-chr $external/weights/weights.hm3_noMHC. 

    # Wei Tian's old commands
    # python {ldscbin}/ldsc.py --h2-cts {sspath} --ref-ld-chr {baseline} --out {outrltdir}/{tr} --ref-ld-chr-cts {ldctsfile} --w-ld-chr {weights}'
    # python {ldscbin}/ldsc.py --h2 {sspath}  --ref-ld-chr {outrundir}/{ct}.,{baseline}  --out {outrltdir}/sep__{ct}.{tr}  --w-ld-chr {weights} --overlap-annot --frqfile-chr {freqs}
