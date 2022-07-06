#!/bin/bash

# Suitable for installations on personal computers (laptop, workstation, cloud)
# Uses Nextflow Secrets instead of AWS Credentials

# Assumes relevant input files are already on the S3 object store

# Enable Nextflow Secrets feature
export NXF_ENABLE_SECRETS=true


# Case 1. use default NF params.input and default NF profile
nextflow -C secrets.config run main.nf

# Case 2. use non-default NF params.input and non-default NF profile
nextflow -C secrets.config run -profile aws_project main.nf \
  --input='s3://pawsey0001-marco-store/input_project_s3'
