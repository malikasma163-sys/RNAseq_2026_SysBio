rule hisat2_align:
    input:
        fastq="results/fastp_filtered/{sample}_filtered.fastq.gz"
    output:
        bam="results/alignment/{sample}/Aligned.sortedByCoord.out.bam",
        log="results/alignment/{sample}/align_summary.txt"
    params:
        index=config["genome_index"]
    conda: "../envs/rnaseq_preprocess.yaml"
    shell:
        "hisat2 -x {params.index} "
        "-U {input.fastq} "
        "--summary-file {output.log} "
        "| samtools sort -o {output.bam} && "
        "samtools index {output.bam}"