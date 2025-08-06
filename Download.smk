
rule all:
    input: "/workspace/yuet/TCR/1.rawData/{projectId}/{runId}.sra"

rule download:
    output: "/workspace/yuet/TCR/1.rawData/{projectId}/{runId}.sra"
    shell:
        """
        prefetch -X 1024102410 {wildcards.runId} -o {output} 
        """
