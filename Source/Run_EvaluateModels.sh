#! /bin/bash

root_dir='/home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2'

languages_dir_list=(
	Dutch/Omega
	French/Omega
	French/Wiktionary
	German/Omega
	German/Wiktionary
	Greek/WordNet
	Italian/Omega
	Italian/WordNet
	Japanese/WordNet
	Russian/Wiktionary
	Spanish/Omega
	Spanish/WordNet
	English/Omega
	English/Wiktionary
	English/WordNet
	English/Oxford
	English/Oxford-pretrainedemb
)

model_types_dir_list=(
	w2v
	Adagram.15-MappingDef2Sense
	Adagram.15-MappingSense2def
)	

echo "For All-mode test sets..."
for i in "${languages_dir_list[@]}"; do
	echo "$i:"
	for j in "${model_types_dir_list[@]}"; do
		echo "$i -> $j (All):"
		python3.7 Evaluate_GeneratedDefinitions.py $root_dir/$i/$j/commondefs/test.txt $root_dir/$i/$j/commondefs/models/cur/gen10.txt 10 all
		echo "----------------------------------------"
	done
	echo "----------------------------------------"
	echo "----------------------------------------"
done

echo "--------------------------############--------------------------------"
echo "--------------------------############--------------------------------"
echo "--------------------------############--------------------------------"
echo "--------------------------############--------------------------------"

echo "For highlyPolysemous-mode test sets..."
for i in "${languages_dir_list[@]}"; do
	echo "$i:"
	for j in "${model_types_dir_list[@]}"; do
		echo "$i -> $j (Polysemous):"
		python3.7 Evaluate_GeneratedDefinitions.py $root_dir/$i/$j/commondefs/test.txt $root_dir/$i/$j/commondefs/models/cur/gen10.txt 10 highlyPolysemous
		echo "----------------------------------------"
	done
	echo "----------------------------------------"
	echo "----------------------------------------"
done

echo "Done!"


