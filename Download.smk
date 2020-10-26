
rule all:
    input: "/workspace/chensy/TCR/1.rawData/{projectId}/{runId}.sra"

rule download:
    output: "/workspace/chensy/TCR/1.rawData/{projectId}/{runId}.sra"
    shell:
        """
        /home/chensy/sratoolkit.2.10.4-ubuntu64/bin/prefetch -X 1024102410 {wildcards.runId} -o {output} 
        """
