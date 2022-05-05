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

echo ""
echo "Please enter the number that identifies your microalgae of interest:"
echo "   1 Ostreococcus tauri              8 Haematococcus lacustris"
echo "   2 Micromonas pusilla CCMP1545     9 Chlomochloris zofingiensis"
echo "   3 Bathycoccus prasinos           10 Klebsormidium nitens "
echo "   4 Coccomyxa subellipsoidea       11 Mesotaenium endlicherianum"
echo "   5 Chlamydomonas reinhardtii      12 Spirogloea muscicola"
echo "   6 Volvox carteri                 13 Phaeodactylum tricornutum"
echo "   7 Dunaliella salina              14 Nannochloropsis gaditana"
read microalgae

microalgae_options=($(seq 1 9))

while ! [[  ${microalgae_options[*]}  =~  $microalgae  ]]
do
 echo "UNKOWN OPTION. Please enter the number that identifies your microalgae "
 echo "of interest:"
 echo "   1 Ostreococcus tauri              8 Haematococcus lacustris"
 echo "   2 Micromonas pusilla CCMP1545     9 Chlomochloris zofingiensis"
 echo "   3 Bathycoccus prasinos           10 Klebsormidium nitens "
 echo "   4 Coccomyxa subellipsoidea       11 Mesotaenium endlicherianum"
 echo "   5 Chlamydomonas reinhardtii      12 Spirogloea muscicola"
 echo "   6 Volvox carteri                 13 Phaeodactylum tricornutum"
 echo "   7 Dunaliella salina              14 Nannochloropsis gaditana"
 read microalgae
done

case $microalgae in
 1)
  echo "microalgae: ostreococcus_tauri" > $filename
 ;;
 2)
  echo "microalgae: micromonas_pusillaCCMP1545" > $filename
 ;;
 3)
  echo "microalgae: bathycoccus_prasinos" > $filename
 ;;
 4)
  echo "microalgae: coccomyxa_subellipsoidea" > $filename
 ;;
 5)
  echo "microalgae: chlamydomonas_reinhardtii" > $filename
 ;;
 6)
  echo "microalgae: volvox_carteri" > $filename
 ;;
 7)
  echo "microalgae: dunaliella_salina" > $filename
 ;;
 8)
  echo "microalgae: haematococcus_lacustris" > $filename
 ;;
 9)
  echo "microalgae: chlomochloris_zofingiensis" > $filename
 ;;
 10)
  echo "microalgae: klebsormidium_nitens" > $filename
 ;;
 11)
  echo "microalgae: mesotaenium_endlicherianum" > $filename
 ;;
 12)
  echo "microalgae: spirogloea_muscicola" > $filename
 ;;
 13)
  echo "microalgae: phaeodactylum_tricornutum" > $filename
 ;;
 14)
  echo "microalgae: nannochloropsis_gaditana" > $filename
 ;;
 *)
  echo ""
  echo "UNKNOWN OPTION. Please"

esac

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
  echo "cluster: SERVER" >> $filename
 elif [ $server_or_cluster -eq 2 ]
 then
  echo "cluster: SLURM" >> $filename
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

echo ""
echo "Please enter the global path to your working directory where the folder "
echo "containing your analysis will be generated (press enter to use the" 
echo "default working directory: $HOME):"
read working_directory

while ! [ -d $working_directory ] 
do
 echo ""
 echo "Sorry the input working directory does not exist. Please enter the "
 echo "global path to an exiiting working directory where the folder "
 echo "containing your analysis will be generated or press enter to use the" 
 echo "default working directory: $HOME:"
 read working_directory
 
 if [ -z $working_directory ]
 then
  working_directory=$HOME
 fi
 
done

if [ -z $working_directory ]
then
 working_directory=$HOME
fi

echo "working_directory: $working_directory" >> $filename



echo ""
echo "Please enter the name of the folder to be generated in your working" 
echo "directory and that will contain all your analysis:"
read main_folder

while [ -d $working_directory/$main_folder ] 
do
 echo ""
 echo "Sorry the folder $working_directory/$main_folder already exist. Please "
 echo "enter a new name: "
 read main_folder
done

echo "main_folder: $main_folder" >> $filename

echo ""
echo "Please enter: "
echo "   1 if your data to be analysed in stored in files in your computer/server"
echo "   2 if your data to be analysed is deposited freely in the SRA or GEO "
echo "     data bases"
read data_source

while [ -z $data_source ] || ([ $data_source -ne 1 ] && [ $data_source -ne 2 ])
do 
 echo "Unknown option please enter only 1 or 2 depending on the source of your data."
 echo "Please enter: "
 echo "   1 if your data to be analysed in stored in files in your computer/server"
 echo "   2 if your data to be analysed is deposited freely in the SRA or GEO "
 echo "     data bases"
 read data_source
done

case $data_source in
 1)
  echo "data_source: FILES" >> $filename
 ;;
 2)
  echo "data_source: DB" >> $filename
 ;;
esac

echo ""
echo "Please enter: "
echo "   1 if your data is NOT paired-end"
echo "   2 if your data is paired-end"
read paired_end

while [ -z $paired_end ] || ([ $paired_end -ne 1 ] && [ $paired_end -ne 2 ])
do 
 echo "Unknown option please enter only 1 or 2 depending on your data being or not"
 echo "paired end."
 echo "Please enter: "
 echo "   1 if your data is NOT paired-end"
 echo "   2 if your data is paired-end"
 read paired_end
done

case $paired_end in
 1)
  echo "paired_end: FALSE" >> $filename
 ;;
 2)
  echo "paired_end: TRUE" >> $filename
 ;;
esac

if [ $rna_seq_or_chip_seq -eq 1 ]
then
 echo " User selected rna-seq"
elif [ $rna_seq_or_chip_seq -eq 2 ]
then
 echo " Your have chosen to specify the parameters for a ChIP-seq analysis."
 echo " "

fi
