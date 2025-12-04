# Whole Genome Sequencing Analysis Pipeline

A comprehensive pipeline for processing and analyzing shallow Whole Genome Sequencing (WGS) data, designed for High-Performance Computing (HPC) environments using SLURM Workload Manager.

## Overview

This pipeline processes WGS data through multiple stages: quality control, sequence alignment, sorting/indexing, duplicate removal, and chromosomal aberration analysis. The pipeline consists of modular Bash scripts for HPC execution and an R script for quantitative DNA sequencing analysis.

## Pipeline Workflow

```
Raw FASTQ files
    ↓
1. Quality Control (QC.sh)
    ↓
2. BWA Alignment (BWA_MAPPING.sh)
    ↓
3. Sorting & Indexing (Samtools_Sort_Index.sh)
    ↓
4. Duplicate Removal (Remove_Duplicates_Picard.sh)
    ↓
5. QDNAseq Analysis (QDNAseq_Analysis.R)
    ↓
Final Analysis Results
```

## Requirements

### Software Dependencies
- **FastQC** (v0.11.9+) - Quality control analysis
- **MultiQC** (v1.9+) - Aggregation of QC reports
- **BWA** (v0.7.17+) - Sequence alignment
- **SAMtools** (v1.11+) - SAM/BAM file manipulation
- **Picard Tools** - Duplicate removal
- **R** with **QDNAseq** package - Chromosomal aberration analysis
- **QDNAseq.hg38** - Reference genome annotations

### System Requirements
- SLURM Workload Manager
- HPC cluster environment
- Sufficient storage for intermediate files

## Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/wgs-pipeline.git
cd wgs-pipeline
```

2. Ensure all required software modules are available on your HPC system

3. Install R dependencies:
```r
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("QDNAseq")
devtools::install_github("asntech/QDNAseq.hg38@main")
```

## Usage

### Configuration

Before running the pipeline, update the following paths in each script:

- **Input data directory**: Update `PARENT_DIR` or input paths
- **Reference genome**: Update `REF_GENOME` path
- **Output directories**: Update output paths as needed
- **Working directories**: Update `setwd()` in R script

### Running the Pipeline

Each script should be submitted as a SLURM job in sequential order. Use job dependencies to ensure proper execution order:

```bash
# Step 1: Quality Control
JOB1=$(sbatch QC.sh | awk '{print $4}')

# Step 2: BWA Alignment (depends on QC)
JOB2=$(sbatch --dependency=afterok:$JOB1 BWA_MAPPING.sh | awk '{print $4}')

# Step 3: Sorting & Indexing (depends on BWA)
JOB3=$(sbatch --dependency=afterok:$JOB2 Samtools_Sort_Index.sh | awk '{print $4}')

# Step 4: Remove Duplicates (depends on sorting)
JOB4=$(sbatch --dependency=afterok:$JOB3 Remove_Duplicates_Picard.sh | awk '{print $4}')

# Step 5: QDNAseq Analysis (run locally or as separate job)
# Rscript QDNAseq_Analysis.R
```

### Scripts Description

1. **QC.sh**: Performs quality checks on raw FASTQ files using FastQC and aggregates reports with MultiQC
2. **BWA_MAPPING.sh**: Aligns sequencing reads to reference genome using BWA-MEM
3. **Samtools_Sort_Index.sh**: Sorts aligned BAM files and creates indexes
4. **Remove_Duplicates_Picard.sh**: Removes PCR duplicates using Picard MarkDuplicates
5. **QDNAseq_Analysis.R**: Analyzes processed BAM files to identify chromosomal aberrations

## Input Data Format

- **Format**: Paired-end FASTQ files (`.fq.gz` or `.fastq.gz`)
- **Naming convention**: Files should follow `*_1.fq.gz` and `*_2.fq.gz` pattern
- **Organization**: Samples should be organized in separate directories

## Output Files

- FastQC reports: `fastqc/` directory
- MultiQC report: `multiqc/` directory
- Aligned BAM files: `BWA/` directory
- Sorted BAM files: `sorted/` directory
- Deduplicated BAM files: `Picard/` directory
- QDNAseq plots: PNG files for each sample

## Citation

If you use this pipeline in your research, please cite:

- [Your manuscript citation here]

## License

[Specify your license here, e.g., MIT, GPL-3.0, or custom]

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Contact

[Your contact information]

## Acknowledgments

- QDNAseq analysis approach based on: https://rpubs.com/mike88bell/854300

