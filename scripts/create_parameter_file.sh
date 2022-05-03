#!/bin/bash

# This script generates the input file for an RNA-seq or ChIP-seq data analysis
echo ""
echo "       /------------------------------------------\ "
echo "       |          Welcome to MARACAS              | "
echo "       |(MicroAlgae RnA-seq and Chip-seq AnalysiS)| "
echo "       |                                          | "
echo "       |   This script will assist you in the     | "
echo "       |   generation of the parameter file for   | "
echo "       |   the execution of our pipelines to      | "
echo "       |   analyse raw RNA-seq or ChIP-seq data.  | "
echo "       |                                          | "
echo "       |  Please enter the requested parameters   | "
echo "       |  and press enter.                        | "
echo "       \------------------------------------------/ "
echo ""
echo ""
echo "Please enter: "
echo "   1 if you want to specify the parameters for an RNA-seq analysis"
echo "   2 if you want to specify the parameters for an ChIP-seq analysis"
read rna_seq_or_chip_seq
echo "The Current User Selection is $rna_seq_or_chip_seq"
