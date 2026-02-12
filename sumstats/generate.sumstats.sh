conda activate /anvil/scratch/x-rwang22/envs/ldsc

INDIR=/anvil/scratch/x-rwang22/GWAS
OUTDIR=/anvil/projects/x-mcb130189/rwang22/bican/ref/gwas_traits
sbatch -p shared --mem=75g --time=20:00:00 --nodes=1 --wrap="/home/x-rwang22/ldsc/munge_sumstats.py --sumstats ${INDIR}/Bellenguez.NatGenet.2022.Alzheimers_Disease_Dementia.formatted.tsv --out ${OUTDIR}/Bellenguez.NatGenet.2022.Alzheimers_Disease_Dementia"
sbatch -p shared --mem=75g --time=20:00:00 --nodes=1 --wrap="/home/x-rwang22/ldsc/munge_sumstats.py --sumstats ${INDIR}/Mullins.NatGenet.2021.Bipolar_Disorder.formatted.tsv --out ${OUTDIR}/Mullins.NatGenet.2021.Bipolar_Disorder"
sbatch -p shared --mem=75g --time=20:00:00 --nodes=1 --wrap="/home/x-rwang22/ldsc/munge_sumstats.py --sumstats ${INDIR}/Wightman.NatGenet.2021.Alzheimers.formatted.tsv --out ${OUTDIR}/Wightman.NatGenet.2021.Alzheimers"