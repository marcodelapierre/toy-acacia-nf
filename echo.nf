#!/usr/bin/env nextflow

params.input='s3://pawsey0001-marco-personal/input_user_s3'
//params.input='s3://pawsey0001-marco-setonix/input_project_s3'

println( file(params.input).text )
