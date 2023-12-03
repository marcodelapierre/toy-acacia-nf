#!/bin/bash

# Suitable for installations on Setonix

# Assumes relevant input files are already on the S3 object store

# Load Nextflow and AWScli in the shell
module load nextflow/22.04.3
module load awscli/1.16.308


# Case 1. use default NF params.input and default S3 profile
nextflow run main.nf

# Case 2. use non-default NF params.input and non-default S3 profile
# profile via with config.aws.profile (requires nf v22.12.0-edge or later)
nextflow run main.nf -profile altprofile \
  --input='s3://pawsey0001-marco-setonix/input_project_acacia'






# Case 3. use local (non S3) params.input
nextflow run main.nf \
  --input='inputs/input_local'
