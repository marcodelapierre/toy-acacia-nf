#!/usr/bin/env nextflow

params.input='s3://pawsey0001-marco-personal/input_user_acacia'

println( file(params.input).text )
