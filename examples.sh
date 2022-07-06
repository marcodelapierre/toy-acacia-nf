#!/bin/bash

AWS_PROFILE='pawsey0001' nextflow run main.nf

nextflow run main.nf --input='s3://pawsey0001-marco-personal/input_user_s3'

nextflow run main.nf --input='inputs/input_local'
