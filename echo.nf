#!/usr/bin/env nextflow

params.input='s3://pawsey0001-marco-personal/input_user_acacia'
//params.input='s3://pawsey0001-marco-setonix/input_project_acacia'

println( file(params.input).text )
