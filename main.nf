#!/usr/bin/env nextflow

params.input='s3://pawsey0001-marco-personal/input_user_acacia'

// just a way to generate directory and name for the output file
// assumes params.input contains both directory and name
// e.g. './input' works, whereas 'input' does not
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
