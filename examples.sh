#!/bin/bash

# Suitable for installations on personal computers (laptop, workstation, cloud)

# Assumes relevant input files are already on the S3 object store






# Case 1. use default NF params.input and default S3 profile
nextflow run main.nf

# Case 2. use non-default NF params.input and non-default S3 profile
# profile via with config.aws.profile (requires nf v22.12.0-edge or later)
nextflow run main.nf \
  -profile altprofile \
  --input='s3://pawsey0001-marco-setonix/input_project_acacia'

# Case 2.b use non-default NF params.input and non-default S3 profile
# profile via AWS_PROFILE env variable (legacy, nf prior to v22.12.0-edge)
AWS_PROFILE="acacia-pawsey0001" \
  nextflow run main.nf \
  --input='s3://pawsey0001-marco-setonix/input_project_acacia'

# Case 3. use local (non S3) params.input
nextflow run main.nf \
  --input='inputs/input_local'


# Case 4. use Fusion FS (requires v22.10.0 or later)
AWS_ACCESS_KEY_ID="" \
  AWS_SECRET_ACCESS_KEY="" \
  nextflow run main.nf \
  -profile standard,fusion


# Use Nextflow Secrets instead of AWS Credentials
# Need to enable Nextflow Secrets feature via env var

# Case 5. use Secrets, default NF params.input and default NF profile
NXF_ENABLE_SECRETS="true" \
  nextflow run main.nf \
  -profile secrets

# Case 2. use Secrets, non-default NF params.input and non-default NF profile
NXF_ENABLE_SECRETS="true" \
  nextflow run main.nf \
  -profile secrets_altprofile \
  --input='s3://pawsey0001-marco-setonix/input_project_acacia'
