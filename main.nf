#!/usr/bin/env nextflow

params.input='s3://pawsey0001-marco-personal/input_user_acacia'

// just a way to generate directory and name for the output file
arr = params.input.split("/",-1)
input_element = arr[arr.size()-1]
if ( arr.size() > 1 ) {
  params.outdir = params.input - input_element
} else {
  params.outdir = '.'
}
params.outfile = 'output' + input_element.replace('input','')


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
