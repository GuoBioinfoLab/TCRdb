mixcr_path = "/home/chensy/mixcr-3.0.13/mixcr"
command_temp = "snakemake -s /workspace/chensy/TCR/01.Script/22_Runmixcr_TRB.sm /workspace/chensy/TCR/mixcrResult/PRJNA297261/SRR2549146.TRB.mixcr"

rule all:
    input: "/workspace/chensy/TCR/mixcrResult/{projectId}/{runId}.TRB.mixcr"

rule align:
    input: "/workspace/chensy/TCR/2.afterQC/{projectId}/{runId}.afterQC.fastq.gz"
    output: temp("{projectId}_{runId}.vdjca")
    threads: 8
    shell:
        """
        timeout 10800 {mixcr_path} align -f -s hs -t {threads} {input} {output}
        """
        
rule assemble:
    input: rules.align.output
    output: temp("{projectId}_{runId}.clns")
    threads: 8
    shell:
        """
        timeout 10800 {mixcr_path} assemble -t {threads} -f {input} {output}
        """
        
rule export:
    input: rules.assemble.output,
    output: "/workspace/chensy/TCR/mixcrResult/{projectId}/{runId}.TRB.mixcr",
    threads: 8
    shell:
        """
        timeout 10800 {mixcr_path} exportClones -o -t -f -c TRB {input} {output}
        """

