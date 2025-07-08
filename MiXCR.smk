mixcr_path = "/home/yuet/mixcr-4.1.0/mixcr"
command_temp = "snakemake -s /workspace/yuet/TCR/01.Script/22_Runmixcr_TRB.sm /workspace/yuet/TCR/mixcrResult/PRJNA297261/SRR2549146.TRB.mixcr"

rule all:
    input: "/workspace/yuet/TCR/mixcrResult/{projectId}/{runId}.TRB.mixcr"

rule align:
    input: "/workspace/yuet/TCR/2.afterQC/{projectId}/{runId}.afterQC.fastq"
    output: temp("{projectId}_{runId}.vdjca")
    threads: 32
    shell:
        """
        timeout 10800 {mixcr_path} align -f -s hs -t {threads} {input} {output}
        """
        
rule assemble:
    input: rules.align.output
    output: temp("{projectId}_{runId}.clns")
    shell:
        """
        timeout 10800 {mixcr_path} assemble -f {input} {output}
        """
        
rule export:
    input: rules.assemble.output,
    output: "/workspace/yuet/TCR/mixcrResult/{projectId}/{runId}.TRB.mixcr",
    shell:
        """
        timeout 10800 {mixcr_path} exportClones -o -t -f -c TRB {input} {output}
        """

