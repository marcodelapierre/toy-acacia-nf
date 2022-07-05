#!/usr/bin/env nextflow

//params.input='s3://pawsey0001-marco-personal/input_user_s3'
params.input='s3://pawsey0001-marco-store/input_project_s3'

arr=params.input.split("/",-1)
params.outdir=params.input-arr[arr.size()-1]
params.outfile=arr[arr.size()-1].replace('input','output')


process analyse {
publishDir params.outdir, mode: 'copy', saveAs: { params.outfile }

input:
path('inp')

output:
path('out')

script:
"""
cat inp >out
echo "File processed by Nextflow.">>out
"""
}


workflow {

input = channel.fromPath(params.input)
analyse(input)

}
