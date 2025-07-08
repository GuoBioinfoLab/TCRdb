temp_path = "/workspace/yuet/temp"

rule all:
    input: 
        "/workspace/yuet/TCR/2.afterQC/{projectId}/{runId}_1.afterQC.fastq",
        "/workspace/yuet/TCR/2.afterQC/{projectId}/{runId}_2.afterQC.fastq"

rule sratoolkit:
    input:
        "/workspace/yuet/TCR/1.rawData/{projectId}/{runId}.sra",
    output:
        temp("/workspace/yuet/temp/{projectId}/{runId}_1.fastq"),
        temp("/workspace/yuet/temp/{projectId}/{runId}_2.fastq")
    shell:
        """
        fasterq-dump -e 16 --split-files {input} -o {temp_path}/{wildcards.projectId}/{wildcards.runId}
        """

rule QC:
    input: rules.sratoolkit.output
    output: 
        "/workspace/yuet/TCR/2.afterQC/{projectId}/{runId}_1.afterQC.fastq",
        "/workspace/yuet/TCR/2.afterQC/{projectId}/{runId}_2.afterQC.fastq"
    threads: 16
    shell:
        """
        fastp -i {input[0]} -o {output[0]} -I {input[1]} -O {output[1]} -M 25 -q 25 -l 40 -w {threads}
        """        
        
