#!/bin/bash

# Suitable for installations on personal computers (laptop, workstation, cloud)

# Assumes relevant input files are already on the S3 object store






# Case 1. use default NF params.input and default S3 profile
nextflow run main.nf

# Case 2. use non-default NF params.input and non-default S3 profile
AWS_PROFILE='acacia-pawsey0001' nextflow run main.nf \
  --input='s3://pawsey0001-marco-setonix/input_project_acacia'

# Case 2.b with config.aws.profile (requires nf v22.12.0-edge or later)
nextflow -C profile.config run main.nf \
  --input='s3://pawsey0001-marco-setonix/input_project_acacia'

# Case 3. use local (non S3) params.input
nextflow run main.nf \
  --input='inputs/input_local'

# Case 4. use Fusion FS (requires v22.10.0 or later)
  export AWS_ACCESS_KEY_ID=
  export AWS_SECRET_ACCESS_KEY=
nextflow -C fusion.config run main.nf