#! /bin/bash

emb_dir=/home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/Embeddings--IG--/Word2vec/FastTextPreProcessingOnWikipedia/ToUse

echo "converting w2v embeddings..."

th w2vutils_modified.lua --binfilename $emb_dir/wiki-w2v.de.bin --outfilename $emb_dir/wiki-w2v.de.t7
th w2vutils_modified.lua --binfilename $emb_dir/wiki-w2v.el.bin --outfilename $emb_dir/wiki-w2v.el.t7
th w2vutils_modified.lua --binfilename $emb_dir/wiki-w2v.en.bin --outfilename $emb_dir/wiki-w2v.en.t7
th w2vutils_modified.lua --binfilename $emb_dir/wiki-w2v.es.bin --outfilename $emb_dir/wiki-w2v.es.t7
th w2vutils_modified.lua --binfilename $emb_dir/wiki-w2v.fr.bin --outfilename $emb_dir/wiki-w2v.fr.t7
th w2vutils_modified.lua --binfilename $emb_dir/wiki-w2v.it.bin --outfilename $emb_dir/wiki-w2v.it.t7
th w2vutils_modified.lua --binfilename $emb_dir/wiki-w2v.ja.bin --outfilename $emb_dir/wiki-w2v.ja.t7
th w2vutils_modified.lua --binfilename $emb_dir/wiki-w2v.nl.bin --outfilename $emb_dir/wiki-w2v.nl.t7
th w2vutils_modified.lua --binfilename $emb_dir/wiki-w2v.ru.bin --outfilename $emb_dir/wiki-w2v.ru.t7

echo "converting adagram embeddings..."

emb_dir=/home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/Embeddings--IG--/AdaGram-juliaV4/Embeddings/Multilingual/ToUse

th w2vutils_modified.lua --binfilename $emb_dir/AdaGram-DE-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.bin --outfilename $emb_dir/AdaGram-DE-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.t7
th w2vutils_modified.lua --binfilename $emb_dir/AdaGram-EL-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch2.bin --outfilename $emb_dir/AdaGram-EL-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch2.t7
th w2vutils_modified.lua --binfilename $emb_dir/AdaGram-EN-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.bin --outfilename $emb_dir/AdaGram-EN-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.t7
th w2vutils_modified.lua --binfilename $emb_dir/AdaGram-ES-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.bin --outfilename $emb_dir/AdaGram-ES-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.t7
th w2vutils_modified.lua --binfilename $emb_dir/AdaGram-FR-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.bin --outfilename $emb_dir/AdaGram-FR-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.t7
th w2vutils_modified.lua --binfilename $emb_dir/AdaGram-IT-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.bin --outfilename $emb_dir/AdaGram-IT-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.t7
th w2vutils_modified.lua --binfilename $emb_dir/AdaGram-JA-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.bin --outfilename $emb_dir/AdaGram-JA-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.t7
th w2vutils_modified.lua --binfilename $emb_dir/AdaGram-NL-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.bin --outfilename $emb_dir/AdaGram-NL-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.t7
th w2vutils_modified.lua --binfilename $emb_dir/AdaGram-RU-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.bin --outfilename $emb_dir/AdaGram-RU-win10-proto30-min20-300D-0.15-SS1e-5-STe1-17-Epoch1.t7

echo "done"
