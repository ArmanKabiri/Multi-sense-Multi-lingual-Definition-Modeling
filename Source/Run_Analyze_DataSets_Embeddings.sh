#! /bin/bash

datasets_dir='/home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Datasets--IG--'
embeddings_dir='/home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/Embeddings--IG--/AdaGram-juliaV4/Embeddings/Multilingual/ToUse'

languages_dir_list=(
	#Dutch/Omega
	#French/Omega
	#French/Wiktionary
	#German/Omega
	#German/Wiktionary
	#Greek/WordNet
	#Italian/Omega
	#Italian/WordNet
	#Japanese/WordNet
	#Russian/Wiktionary
	#Spanish/Omega
	#Spanish/WordNet
	#English/Omega
	#English/Wiktionary
	English/WordNet

)

declare -A lang_codes=( ["Dutch"]="NL" ["French"]="FR" ["German"]="DE" ["Greek"]="EL" ["Italian"]="IT" ["Japanese"]="JA" ["Russian"]="RU" ["Spanish"]="ES" ["English"]="EN")
echo "${lang_codes[Dutch]}"
# Set comma as delimiter

for i in "${languages_dir_list[@]}"; do
	#Read the split words into an array based on comma delimiter
	IFS='/'
	read -a splitText <<< "$i"
	IFS=''
	lang=$splitText
	langcode="${lang_codes[$lang]}"
	echo "$i  -  lang: $lang  -   langcode: $langcode"
	python3.7 Dataset_MultiSenseEmbedding_Analysis.py $datasets_dir/$i/ReadyToUse/train.txt $embeddings_dir/AdaGram-$langcode-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.bin
		
	echo "----------------------------------------"
	echo "----------------------------------------"
done

