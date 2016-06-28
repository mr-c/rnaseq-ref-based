#!/usr/bin/env cwl-runner

cwlVersion: draft-4.dev2

class: CommandLineTool

inputs:

  alignment_file:
    type: File
    inputBinding:
      position: 1

  gff_file:
    type: File
    inputBinding:
      position: 2

outputs: []

baseCommand: [htseq-count]
