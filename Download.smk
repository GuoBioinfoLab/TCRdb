
rule all:
    input: "/workspace/yuet/TCR/1.rawData/{projectId}/{runId}.sra"

rule download:
    output: "/workspace/yuet/TCR/1.rawData/{projectId}/{runId}.sra"
    shell:
        """
        /home/chensy/sratoolkit.3.1.0-ubuntu64/bin/prefetch -X 1024102410 {wildcards.runId} -o {output} 
        """
