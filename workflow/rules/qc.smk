rule fastqc_raw:
    input:
        lambda wildcards: f"{config['input_path']}/{wildcards.sample}_raw.fastq"
    output:
        html="results/fastqc/{sample}_raw_fastqc.html",
        zip="results/fastqc/{sample}_raw_fastqc.zip"
    conda: "../envs/rnaseq_preprocess.yaml"
    shell:
        "fastqc {input} --outdir results/fastqc/"

rule fastp:
    input:
        lambda wildcards: f"{config['input_path']}/{wildcards.sample}_raw.fastq"
    output:
        fastq="results/fastp_filtered/{sample}_filtered.fastq",
        json="results/fastp/{sample}_fastp.json",
        html="results/fastp/{sample}_fastp.html"
    conda: "../envs/rnaseq_preprocess.yaml"
    shell:
        "fastp -i {input} "
        "-o {output.fastq} "
        "--json {output.json} --html {output.html}"

rule fastqc_filtered:
    input:
        "results/fastp_filtered/{sample}_filtered.fastq"
    output:
        html="results/fastqc/{sample}_filtered_fastqc.html",
        zip="results/fastqc/{sample}_filtered_fastqc.zip"
    conda: "../envs/rnaseq_preprocess.yaml"
    shell:
        "fastqc {input} --outdir results/fastqc/"
