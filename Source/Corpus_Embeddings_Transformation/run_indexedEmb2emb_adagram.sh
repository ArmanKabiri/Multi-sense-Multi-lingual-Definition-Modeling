#! /bin/bash

pyfile=TransformIndexedEmbeddingsToOriginalEmbeddings.py
embdir=/home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/Embeddings--IG--/AdaGram-juliaV4/Embeddings/Multilingual/Indexed
outembdir=/home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/Embeddings--IG--/AdaGram-juliaV4/Embeddings/Multilingual/ToUse
dicdir=/home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/Embeddings-Corpora--IG--/FastText_Corpora/data/wikimedia/20191203/Dictionaries-Frequencies

echo "Starting"

python3.7 $pyfile $embdir/AdaGram-DE-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt $dicdir/wiki-dic.de.txt $outembdir/AdaGram-DE-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt UNK
python3.7 $pyfile $embdir/AdaGram-EL-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch2.txt $dicdir/wiki-dic.el.txt $outembdir/AdaGram-EL-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch2.txt UNK
python3.7 $pyfile $embdir/AdaGram-EN-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt $dicdir/wiki-dic.en.txt $outembdir/AdaGram-EN-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt UNK
python3.7 $pyfile $embdir/AdaGram-ES-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt $dicdir/wiki-dic.es.txt $outembdir/AdaGram-ES-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt UNK
python3.7 $pyfile $embdir/AdaGram-FR-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt $dicdir/wiki-dic.fr.txt $outembdir/AdaGram-FR-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt UNK
python3.7 $pyfile $embdir/AdaGram-IT-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt $dicdir/wiki-dic.it.txt $outembdir/AdaGram-IT-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt UNK
python3.7 $pyfile $embdir/AdaGram-JA-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt $dicdir/wiki-dic.ja.txt $outembdir/AdaGram-JA-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt UNK
python3.7 $pyfile $embdir/AdaGram-NL-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt $dicdir/wiki-dic.nl.txt $outembdir/AdaGram-NL-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt UNK
python3.7 $pyfile $embdir/AdaGram-RU-Transformed-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt $dicdir/wiki-dic.ru.txt $outembdir/AdaGram-RU-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.txt UNK

echo "Done"
