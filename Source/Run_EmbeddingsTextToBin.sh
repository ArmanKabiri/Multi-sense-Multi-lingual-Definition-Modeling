#! /bin/bash

w2v_dir=/home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/Embeddings--IG--/Word2vec/FastTextPreProcessingOnWikipedia/ToUse
adagram_dir=/home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/Embeddings--IG--/AdaGram-juliaV4/Embeddings/Multilingual/ToUse

python3.7 EmbeddingsTextToBin.py $w2v_dir/wiki-w2v.de.txt
python3.7 EmbeddingsTextToBin.py $w2v_dir/wiki-w2v.el.txt
python3.7 EmbeddingsTextToBin.py $w2v_dir/wiki-w2v.en.txt
python3.7 EmbeddingsTextToBin.py $w2v_dir/wiki-w2v.es.txt
python3.7 EmbeddingsTextToBin.py $w2v_dir/wiki-w2v.fr.txt
python3.7 EmbeddingsTextToBin.py $w2v_dir/wiki-w2v.it.txt
python3.7 EmbeddingsTextToBin.py $w2v_dir/wiki-w2v.ja.txt
python3.7 EmbeddingsTextToBin.py $w2v_dir/wiki-w2v.nl.txt
python3.7 EmbeddingsTextToBin.py $w2v_dir/wiki-w2v.ru.txt

echo "w2v embeddings are converted"

python3.7 EmbeddingsTextToBin.py $adagram_dir/AdaGram-DE-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt
python3.7 EmbeddingsTextToBin.py $adagram_dir/AdaGram-EL-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch2.txt
python3.7 EmbeddingsTextToBin.py $adagram_dir/AdaGram-EN-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt
python3.7 EmbeddingsTextToBin.py $adagram_dir/AdaGram-ES-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt
python3.7 EmbeddingsTextToBin.py $adagram_dir/AdaGram-FR-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt
python3.7 EmbeddingsTextToBin.py $adagram_dir/AdaGram-IT-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt
python3.7 EmbeddingsTextToBin.py $adagram_dir/AdaGram-JA-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt
python3.7 EmbeddingsTextToBin.py $adagram_dir/AdaGram-NL-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt
python3.7 EmbeddingsTextToBin.py $adagram_dir/AdaGram-RU-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt

echo "Adagram embeddings are converted"

echo "done!"
