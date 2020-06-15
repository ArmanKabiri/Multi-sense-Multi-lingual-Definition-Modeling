#! /bin/bash

pyfile=TransformIndexedEmbeddingsToOriginalEmbeddings.py
embdir=/home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/Embeddings--IG--/Word2vec/FastTextPreProcessingOnWikipedia/Indexed
outembdir=/home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/Embeddings--IG--/Word2vec/FastTextPreProcessingOnWikipedia/ToUse
dicdir=/home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/Embeddings-Corpora--IG--/FastText_Corpora/data/wikimedia/20191203/Dictionaries-Frequencies

echo "Starting"

python3.7 $pyfile $embdir/wiki-w2v.de.txt $dicdir/wiki-dic.de.txt $outembdir/wiki-w2v.de.txt UNK
python3.7 $pyfile $embdir/wiki-w2v.el.txt $dicdir/wiki-dic.el.txt $outembdir/wiki-w2v.el.txt UNK
python3.7 $pyfile $embdir/wiki-w2v.en.txt $dicdir/wiki-dic.en.txt $outembdir/wiki-w2v.en.txt UNK
python3.7 $pyfile $embdir/wiki-w2v.es.txt $dicdir/wiki-dic.es.txt $outembdir/wiki-w2v.es.txt UNK
python3.7 $pyfile $embdir/wiki-w2v.fr.txt $dicdir/wiki-dic.fr.txt $outembdir/wiki-w2v.fr.txt UNK
python3.7 $pyfile $embdir/wiki-w2v.it.txt $dicdir/wiki-dic.it.txt $outembdir/wiki-w2v.it.txt UNK
python3.7 $pyfile $embdir/wiki-w2v.ja.txt $dicdir/wiki-dic.ja.txt $outembdir/wiki-w2v.ja.txt UNK
python3.7 $pyfile $embdir/wiki-w2v.nl.txt $dicdir/wiki-dic.nl.txt $outembdir/wiki-w2v.nl.txt UNK
python3.7 $pyfile $embdir/wiki-w2v.ru.txt $dicdir/wiki-dic.ru.txt $outembdir/wiki-w2v.ru.txt UNK

echo "Done"
