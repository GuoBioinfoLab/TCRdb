temp_path = "/workspace/yuet/temp"

rule all:
    input: 
        "/workspace/yuet/TCR/2.afterQC/{projectId}/{runId}.afterQC.fastq"

rule sratoolkit:
    input:
        "/workspace/yuet/TCR/1.rawData/{projectId}/{runId}.sra",
    output:
        temp("/workspace/yuet/temp/{projectId}/{runId}.fastq"),
    shell:
        """
        fasterq-dump -e 16 --split-files {input} -o {temp_path}/{wildcards.projectId}/{wildcards.runId}
        """

rule QC:
    input: rules.sratoolkit.output
    output: 
        "/workspace/yuet/TCR/2.afterQC/{projectId}/{runId}.afterQC.fastq",
    threads: 16
    shell:
        """
        fastp -i {input[0]} -o {output[0]} -M 25 -q 25 -l 40 -w {threads}
        """        
