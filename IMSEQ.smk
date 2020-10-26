imseq_path = "/home/chensy/imseq/imseq"

rule all:
    input: "/workspace/chensy/TCR/imseqResult/{projectId}/{runId}.TRB.imseq"
    
rule imseq:
    input: "/workspace/chensy/TCR/2.afterQC/{projectId}/{runId}.afterQC.fastq.gz"
    output: "/workspace/chensy/TCR/imseqResult/{projectId}/{runId}.TRB.imseq"
    threads: 16
    shell:
        """
        timeout 10800 {imseq_path} -j {threads} -ref /home/chensy/imseq/Homo.Sapiens.TRB.fa -ma -qc -sc {input} -oa {output}
        """
