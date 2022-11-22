#!/bin/bash

# This bash script loops through PLEPs and converts the
# ReStructuredText (.rst) files into PDF files with a consistent
# style.
#
# The author metadata right now must be implemented manually in order
# for middle initials to be included.
#
# This script may be run using:
#
#   bash convert_to_pdf.sh
#
# This script requires that pandoc and pdflatex be installed.

pdf_engine=pdflatex

options="-V papersize:letter -V geometry:margin=1in -V fontsize=12pt -V linestretch=1.07 -V colorlinks"

# Enter pdf metadata manually

authors=( \
    [0000]="PlasmaPy Community" \
    [0001]="Nicholas A. Murphy" \
    [0002]="Nicholas A. Murphy" \
    [0003]="PlasmaPy Community" \
    [0004]="Nicholas A. Murphy" \
    [0005]="Nicholas A. Murphy and Stuart J. Mumford" \
    [0006]="Andrew J. Leonard" \
    [0007]="Erik T. Everson" \
)

for rstfile in PLEP-????.rst; do

    base=${rstfile%.rst}
    number=${base//PLEP-/}
    pdffile=${base}.pdf

    author=${authors[${number}]:-""}

    echo "Converting ${rstfile} to ${pdffile}"
    echo "Author = ${author}"

    pandoc \
	${rstfile} \
	-o ${pdffile} \
	--pdf-engine=${pdf_engine} \
	${options} \
	-M author="${author}" \
	-M subject="PlasmaPy Enhancement Proposal"

    echo ""

done
