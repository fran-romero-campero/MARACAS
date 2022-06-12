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
 echo "You have chosen to specify the parameters for a RNA-seq analysis."
 echo ""
 echo "Please enter the name of the experimental condition in your analysis:"
 read experimental_condition_name
 echo "experimental_condition_name: $experimental_condition_name"  >> $filename 
 
 echo " "
 echo "Please enter the number of replicates for your experimental condition"
 echo "$experimental_condition_name :"
 read experimental_replicate_number

 if [[ $experimental_replicate_number =~ ^[0-9]+$ ]]
  then
   for i in $(seq 1 $experimental_replicate_number)
   do
    echo "condition_sample$i: $experimental_condition_name"  >> $filename
    echo " "
    echo "Please enter complete path including the fastq file for replicate $i"
    echo "of the experimental condition $experimental_condition_name:"
    read experimental_replicate_path
    echo "loc_sample$i:" $experimental_replicate_path >> $filename
   done
  else
   while  ! [[ $experimental_replicate_number =~ ^[0-9]+$ ]] 
   do
    echo " "
    echo "Please enter the number of replicates for your experimental condition"
    echo "$experimental_condition_name you did not enter a number:"
    read experimental_replicate_number
   done
   for i in $(seq 1 $experimental_replicate_number)
   do
    echo "condition_sample$i: $experimental_condition_name"  >> $filename
    echo " "
    echo "Please enter complete path including the fastq file for replicate $i"
    echo "of the experimental condition $experimental_condition_name:"
    read experimental_replicate_path
    echo "loc_sample$i:" $experimental_replicate_path >> $filename
   done
 fi
 echo ""
 echo "Please enter the name of the control condition in your analysis:"
 read control_condition_name
 echo "control_condition_name: $control_condition_name" >> $filename 
 echo " "
 echo "Please enter the number of replicates for your control condition"
 echo "$control_condition_name :"
 read control_replicate_number

 if [[ $control_replicate_number =~ ^[0-9]+$ ]]
  then
   for i in $(seq 1 $control_replicate_number)
   do
    echo "condition_sample$i: $control_condition_name"  >> $filename
    echo " "
    echo "Please enter complete path including the fastq file for replicate $i"
    echo "of the control condition $control_condition_name:"
    read control_replicate_path
    echo "loc_sample$i:" $control_replicate_path >> $filename
   done
  else
   while  ! [[ $control_replicate_number =~ ^[0-9]+$ ]] 
   do
    echo " "
    echo "Please enter the number of replicates for your control condition"
    echo "$control_condition_name you did not enter a number:"
    read control_replicate_number
   done
   for i in $(seq 1 $control_replicate_number)
   do
    echo "condition_sample$i: $control_condition_name"  >> $filename
    echo " "
    echo "Please enter complete path including the fastq file for replicate $i"
    echo "of the control condition $experimental_condition_name:"
    read control_replicate_path
    echo "loc_sample$i:" $control_replicate_path >> $filename
   done
 fi
 echo " "
 echo "Parameters for Differential Gene Expression (DEG) analysis."
 echo "Please enter the fold change threshold to determine differentially"
 echo "expressed genes. Suggested values:"
 echo " - Fold change 2: this is the most common value. A 2-fold increase or"
 echo "   decrease in gene expression is used to determine activated/repressed"
 echo "   gene in the experimental condition with respect to the control."
 echo " - Fold change 4: this is a restrictive value. A 4-fold increase or"
 echo "   decrease in gene expression is used to determine activated/repressed"
 echo "   gene in the experimental condition with respect to the control."
 echo " - Fold change 8: this is a very restrictive value only used when a"
 echo "   massive change is expected in the experimental condition when compared"
 echo "   to the control condition."
 echo "Please enter your selected fold change threshold:"
 read fold_change
 echo "fold_change: $fold_change" >> $filename
 echo " "
 echo "Please enter the ajdusted p-value or q-value to determine differentially"
 echo "expressed genes. Suggested values:"
 echo " - q-value of 0.05: this is the most common value. A 95% signficance"
 echo "   level in gene expression is used to determine activated/repressed"
 echo "   gene in the experimental condition with respect to the control."
 echo " - q-value of 0.1: this is a permissive value. A 90% signficance"
 echo "   level in gene expression is used to determine activated/repressed"
 echo "   gene in the experimental condition with respect to the control."
 echo " - q-value of 1: Only the fold change criterion is used. No control over"
 echo "   false positives. Very permissive criterion."
 echo "Please enter your selected q-value threshold:"
 read q_value
 echo "q_value: $q_value" >> $filename
elif [ $rna_seq_or_chip_seq -eq 2 ]
then
 echo " You have chosen to specify the parameters for a ChIP-seq analysis."
 echo " "

fi
