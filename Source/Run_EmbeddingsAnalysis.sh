#! /bin/bash

embeddings_root_dir='/home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/Embeddings--IG--/AdaGram-juliaV4/Embeddings/Multilingual/ToUse'

lang_codes=(
DE
EN
ES
FR
IT
JA
NL
RU
)

for i in "${lang_codes[@]}"; do
	echo "$i:"
	python3.7 EmbeddingsAnalysis.py $embeddings_root_dir/AdaGram-$i-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.bin
	echo
done

echo "EL:"
python3.7 EmbeddingsAnalysis.py $embeddings_root_dir/AdaGram-EL-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch2.bin

echo "DONE!"
