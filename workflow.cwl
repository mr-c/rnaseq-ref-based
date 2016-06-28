#!/usr/bin/env cwl-runner

cwlVersion: draft-4.dev2

class: Workflow

requirements:
  - $import: paired-reads-type.yaml
  - class: ScatterFeatureRequirement
 
inputs:
 
  replicates:
    type:
      type: array
      items: "paired-reads-type.yaml#paired-reads"

  mate-inner-dist:
    type: int

  reference_genome_gff:
    type: File

  reference_genome_bowtie_index:
    type: File
    secondaryFiles:
      - ^.2.bt2
      - ^.3.bt2
      - ^.4.bt2
      - ^.rev.1.bt2
      - ^.rev.2.bt2

outputs: []

steps:
  tophat:
    in:
      paired-reads:
        source: replicates
      bowtie_index:
        source: reference_genome_bowtie_index
      mate-inner-dist:
        source: mate-inner-dist
    out:
      - accepted_hits
    run: tophat2.cwl
    scatter: paired-reads

  htseq-count:
    in:
      alignment_file:
        source: "#tophat/accepted_hits"
      gff_file:
        source: reference_genome_gff
    out: []
    run: htseq-count.cwl
