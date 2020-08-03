command_sample = "snakemake -s /workspace/chensy/TCR/01.Script/23_Runcatt_TRB.sm -np /workspace/chensy/TCR/cattResult/PRJNA258001/SRR1544022.TRB.catt"

rule all:
    input: "/workspace/chensy/TCR/cattResult/{projectId}/{runId}.TRB.catt"

rule catt:
    input: "/workspace/chensy/TCR/2.afterQC/{projectId}/{runId}.afterQC.fastq.gz"
    output: "/workspace/chensy/TCR/cattResult/{projectId}/{runId}.TRB.catt"
    threads: 16
    shell:
        """
        cd /workspace/chensy/TCR/2.afterQC/{wildcards.projectId}
        docker run --rm -u $UID -v $PWD:/outside -w /outside guobioinfolab/catt catt -f {wildcards.runId}.afterQC.fastq.gz -o {wildcards.runId} --bowt 16 -t 8 --chain TRB
        mv {wildcards.runId}.TRB.CDR3.CATT.csv {output}
        """
