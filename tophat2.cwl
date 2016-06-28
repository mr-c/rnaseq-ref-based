#!/usr/bin/env cwl-runner

cwlVersion: draft-4.dev2

class: CommandLineTool

requirements:
  - $import: paired-reads-type.yaml
  - class: InlineJavascriptRequirement

inputs:

  mate-inner-dist:
    type: ["null", int]
    inputBinding:
      prefix: --mate-inner-dist

  num-threads:
    type: ["null", int]
    description: | 
      Change number of threads used
    inputBinding:
      prefix: --num-threads

  mate-std-dev:
    type: ["null", int]
    inputBinding:
      prefix: --mate-std-dev

  max-intron-length:
    type: ["null", int]
    inputBinding:
      prefix: --max-intron-length

  fusion-min-dist:
    type: ["null", int]
    inputBinding:
      prefix: --fusion-min-dist

  fusion-anchor-length:
    type: ["null", int]
    inputBinding:
      prefix: --fusion-anchor-length

  fusion-ignore-chromosomes:
    type: ["null", string]
    inputBinding:
      prefix: --fusion-ignore-chromosomes

  # Boolean values, shows prefix only
  fusion-search:
    type: ["null", boolean]
    description: | 
      Turn on fusion algorithm (tophat-fusion)
    inputBinding:
      prefix: --fusion-search

  keep-fasta-order:
    type: ["null", boolean]
    description: | 
      Keep ordering of fastq file
    inputBinding:
      prefix: --keep-fasta-order
  
  bowtie1:
    type: ["null", boolean]
    description: | 
      Use bowtie1
    inputBinding:
      prefix: --bowtie1

  no-coverage-search:
    type: ["null", boolean]
    description: | 
      Turn off coverage-search, which takes lots of memory and is slow
    inputBinding:
      prefix: --no-coverage-search

  library-type:
    type:
      - "null"
      - type: enum
        name: librarytype
        symbols:
         - fr-unstranded
         - fr-firststrand
         - fr-secondstrand

  ## Required files ##
  paired-reads:
    type: "paired-reads-type.yaml#paired-reads"

  bowtie_index:
    type: File
    secondaryFiles:
      - ^.2.bt2
      - ^.3.bt2
      - ^.4.bt2
      - ^.rev.1.bt2
      - ^.rev.2.bt2

outputs:

  accepted_hits:
    type: File
    outputBinding:
      glob: "tophat_out/accepted_hits.bam"

baseCommand: [tophat]
arguments:
  - valueFrom: $(inputs.bowtie_index.path.slice(0,-3))
    position: 1
