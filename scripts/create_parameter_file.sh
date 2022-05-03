#!/bin/bash

# This script generates the input file for an RNA-seq or ChIP-seq data analysis
echo ""
echo "       /--------------------------------------------\ "
echo "       |           Welcome to MARACAS               | "
echo "       | (MicroAlgae RnA-seq and Chip-seq AnalysiS) | "
echo "       |                                            | "
echo "       |    This script will assist you in the      | "
echo "       |    generation of the parameter file for    | "
echo "       |    the execution of our pipelines to       | "
echo "       |    analyse raw RNA-seq or ChIP-seq data.   | "
echo "       |                                            | "
echo "       |   Please enter the requested parameters    | "
echo "       |   and press enter.                         | "
echo "       \--------------------------------------------/ "
echo ""
echo ""
echo "Please enter the name of the file where your parameters will be written:"
read filename
echo ""
echo "Please enter: "
echo "   1 if you want to specify the parameters for an RNA-seq analysis"
echo "   2 if you want to specify the parameters for an ChIP-seq analysis"
read rna_seq_or_chip_seq

while [ -z $rna_seq_or_chip_seq ] || ([ $rna_seq_or_chip_seq -ne 1 ] && [ $rna_seq_or_chip_seq -ne 2 ])
do 
 echo "Unknown option please enter only 1 or 2 depending of the analysis you"
 echo "want to perform."
 echo "Please enter: "
 echo "   1 if you want to specify the parameters for an RNA-seq analysis"
 echo "   2 if you want to specify the parameters for an ChIP-seq analysis"
 read rna_seq_or_chip_seq
done

if [ $rna_seq_or_chip_seq -eq 1 ]
then
 echo " User selected rna-seq"
elif [ $rna_seq_or_chip_seq -eq 2 ]
then
 echo " Your have chosen to specify the parameters for a ChIP-seq analysis."
 echo " "
 echo "Please enter: "
 echo "   1 if you will run MARACAS on your computer or server in sequential mode"
 echo "   2 if you will run MARACAS on a computer cluster in parallel mode with SLURM"
 read server_or_cluster
 echo ""
 while [ -z $server_or_cluster ] || ([ $server_or_cluster -ne 1 ] && [ $server_or_cluster -ne 2 ])
 do 
  echo "Unknown option please enter only 1 or 2 depending on the platform in which you"
  echo "will run MARACAS."
  echo "Please enter: "
  echo "   1 if you will run MARACAS on your computer or server in sequential mode"
  echo "   2 if you will run MARACAS on a computer cluster in parallel mode with SLURM"
  read server_or_cluster
 done
 
 if [ $server_or_cluster -eq 1 ]
 then
  echo "cluster: SERVER" > $filename
 elif [ $server_or_cluster -eq 2 ]
 then
  echo "cluster: SLURM" > $filename
 fi
 
 echo " "
 echo "Please enter the number of processors to use in the analysis "
 echo "or press enter for the default value of 1 processor: "
 read number_processors

 if [ -z $number_processors ]
 then
  echo "number_processors: 1" >> $filename
 elif [[ $number_processors =~ ^[0-9]+$ ]]
 then
  echo "number_processors: $number_processors" >> $filename
 else
   while  ! [[ $number_processors =~ ^[0-9]+$ ]] 
   do
    echo " "
    echo "Please enter the number of processors to use in the analysis "
    echo "you did not enter a number: "
    read number_processors
   done
   echo "number_processors: $number_processors" >> $filename
 fi

fi
