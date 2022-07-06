#!/bin/bash

# Suitable for installations on personal computers (laptop, workstation, cloud)

# Case 1. use default NF params.input and default S3 profile
nextflow run main.nf

# Case 2. use non-default NF params.input and non-default S3 profile
AWS_PROFILE='pawsey0001' nextflow run main.nf \
  --input='s3://pawsey0001-marco-store/input_project_s3'

# Case 3. use local (non S3) params.input
nextflow run main.nf \
  --input='inputs/input_local'
