rule multiqc:
    input:
        fastqc_raw=expand("results/fastqc/{sample}_raw_fastqc.zip", sample=config["samples"]),
        fastqc_filtered=expand("results/fastqc/{sample}_filtered_fastqc.zip", sample=config["samples"]),
        fastp=expand("results/fastp/{sample}_fastp.json", sample=config["samples"]),
        hisat=expand("results/alignment/{sample}/align_summary.txt", sample=config["samples"]),
        featureCounts=expand("results/counts/{sample}.featureCounts.txt.summary", sample=config["samples"])
    output:
        "results/multiqc/multiqc_report.html"
    conda: "../envs/multiqc.yaml"
    shell:
        "multiqc --verbose --outdir results/multiqc/ --force "
        "{input.fastqc_raw} {input.fastqc_filtered} {input.fastp} {input.hisat} {input.featureCounts}"
