rule featurecounts:
    input:
        bams=expand("results/alignment/{sample}/Aligned.sortedByCoord.out.bam",
                    sample=config["samples"]),
        gtf=config["gtf"]
    output:
        counts="results/counts/counts.txt",
        summary="results/counts/counts.txt.summary"
    conda: "../envs/rnaseq_preprocess.yaml"
    shell:
        "featureCounts -T 4 "
        "-a {input.gtf} "
        "-o {output.counts} "
        "{input.bams}"