trimmomatic_path = "java -jar /home/chensy/Trimmomatic-0.39/trimmomatic-0.39.jar "
temp_path = "/workspace/chensy/temp"

CROP = "Trimmomatic: cut from tail"
HEADCROP: "Trimmomatic: cut from head"

rule all:
    input: "/workspace/chensy/TCR/2.afterQC/{projectId}/{runId}.afterQC.fastq.gz"

rule sratoolkit:
    input:
        "/workspace/chensy/TCR/1.rawData/{projectId}/{runId}.sra",
    output:
        temp("/workspace/chensy/temp/{projectId}/{runId}_1.fastq"),
        temp("/workspace/chensy/temp/{projectId}/{runId}_2.fastq")
    shell:
        """
        /home/chensy/sratoolkit.2.10.4-ubuntu64/bin/fasterq-dump -e 16 --split-files {input} -o {temp_path}/{wildcards.projectId}/{wildcards.runId}
        """

rule QC:
    input: rules.sratoolkit.output
    output: 
        temp("/workspace/chensy/temp/{projectId}/{runId}_trimed_1.fastq"),
        temp("/workspace/chensy/temp/{projectId}/{runId}_trimed_2.fastq"),
        temp("/workspace/chensy/temp/{projectId}/{runId}_unpaired_1.fastq"),
        temp("/workspace/chensy/temp/{projectId}/{runId}_unpaired_2.fastq")
    threads: 16
    shell:
        """
        {trimmomatic_path} PE -threads {threads} {input} \
        {output[0]} {output[2]} {output[1]} {output[3]} \
        ILLUMINACLIP:/home/chensy/Trimmomatic-0.39/adapters/TruSeq3-SE.fa:2:30:10 \
        SLIDINGWINDOW:8:25 \
        LEADING:25  \
        TRAILING:25 
        
        """

rule pear:
    input: rules.QC.output
    output:
        temp("/workspace/chensy/temp/{projectId}/{runId}.pear.temp.fastq"),
    threads: 16
    shell:
        """
        /project/chensy/pear -j {threads} -f {input[0]} -r {input[1]} -o {temp_path}/{wildcards.runId}
        cat {temp_path}/{wildcards.runId}.assembled.fastq {temp_path}/{wildcards.runId}.unassembled.forward.fastq {temp_path}/{wildcards.runId}.unassembled.reverse.fastq {input[2]} {input[3]} > {output}
        rm {temp_path}/{wildcards.runId}.assembled.fastq {temp_path}/{wildcards.runId}.unassembled.forward.fastq {temp_path}/{wildcards.runId}.unassembled.reverse.fastq {temp_path}/{wildcards.runId}.discarded.fastq
        """

rule rename:
    input: rules.pear.output
    output:
        temp("/workspace/chensy/temp/{projectId}/{runId}.pear.total.fastq")
    params:
        cnnd = "awk '{print (NR%4 == 1)? \"@1_\" ++i : $0}'"
    shell:
        "{params.cnnd} {input[0]} > {output} "
        

rule lenMovement:
    input: rules.rename.output
    output:
        "/workspace/chensy/temp/{projectId}/{runId}.afterQC.fastq"
    shell:
        "{trimmomatic_path} SE -threads 16 {input} {output} MINLEN:40"

rule GzipOutput:
    input: rules.lenMovement.output
    output: "/workspace/chensy/TCR/2.afterQC/{projectId}/{runId}.afterQC.fastq.gz"
    shell: "gzip {input} -c > {output}"
        
