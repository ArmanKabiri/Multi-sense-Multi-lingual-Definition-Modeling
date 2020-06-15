#! /bin/bash

echo "*******************************************"
echo "---------Running prep_definition.lua-------"
echo "*******************************************"

echo "Dutch:"
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Dutch/Omega/Adagram.15-MappingDef2Sense/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Dutch/Omega/Adagram.15-MappingSense2def/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Dutch/Omega/w2v/commondefs

echo "French:"
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/French/Omega/Adagram.15-MappingDef2Sense/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/French/Omega/Adagram.15-MappingSense2def/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/French/Omega/w2v/commondefs

th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/French/Wiktionary/Adagram.15-MappingDef2Sense/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/French/Wiktionary/Adagram.15-MappingSense2def/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/French/Wiktionary/w2v/commondefs

echo "German:"
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/German/Omega/Adagram.15-MappingDef2Sense/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/German/Omega/Adagram.15-MappingSense2def/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/German/Omega/w2v/commondefs

th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/German/Wiktionary/Adagram.15-MappingDef2Sense/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/German/Wiktionary/Adagram.15-MappingSense2def/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/German/Wiktionary/w2v/commondefs

echo "Greek:"
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Greek/WordNet/Adagram.15-MappingDef2Sense/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Greek/WordNet/Adagram.15-MappingSense2def/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Greek/WordNet/w2v/commondefs

echo "Italian:"
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Italian/Omega/Adagram.15-MappingDef2Sense/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Italian/Omega/Adagram.15-MappingSense2def/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Italian/Omega/w2v/commondefs

th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Italian/WordNet/Adagram.15-MappingDef2Sense/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Italian/WordNet/Adagram.15-MappingSense2def/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Italian/WordNet/w2v/commondefs

echo "Japanese:"
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Japanese/WordNet/Adagram.15-MappingDef2Sense/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Japanese/WordNet/Adagram.15-MappingSense2def/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Japanese/WordNet/w2v/commondefs

echo "Russian:"
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Russian/Wiktionary/Adagram.15-MappingDef2Sense/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Russian/Wiktionary/Adagram.15-MappingSense2def/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Russian/Wiktionary/w2v/commondefs

echo "Spanish:"
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Spanish/Omega/Adagram.15-MappingDef2Sense/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Spanish/Omega/Adagram.15-MappingSense2def/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Spanish/Omega/w2v/commondefs

th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Spanish/WordNet/Adagram.15-MappingDef2Sense/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Spanish/WordNet/Adagram.15-MappingSense2def/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Spanish/WordNet/w2v/commondefs

echo "English:"
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/Omega/Adagram.15-MappingDef2Sense/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/Omega/Adagram.15-MappingSense2def/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/Omega/w2v/commondefs

th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/Wiktionary/Adagram.15-MappingDef2Sense/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/Wiktionary/Adagram.15-MappingSense2def/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/Wiktionary/w2v/commondefs

th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/WordNet/Adagram.15-MappingDef2Sense/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/WordNet/Adagram.15-MappingSense2def/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/WordNet/w2v/commondefs

th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/GCIDE-WN/Adagram.15-MappingDef2Sense/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/GCIDE-WN/Adagram.15-MappingSense2def/commondefs
th prep_definition.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/GCIDE-WN/w2v/commondefs

echo "@@@@@@@@@@@@ ---- DONE -----@@@@@@@@@@@@@\n\n"

echo "*******************************************"
echo "----------Running prep_w2v.lua--------"
echo "*******************************************"

echo "Dutch w2v:"
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Dutch/Omega/Adagram.15-MappingDef2Sense/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Dutch/Omega/Adagram.15-MappingDef2Sense/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Dutch/Omega/Adagram.15-MappingSense2def/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Dutch/Omega/Adagram.15-MappingSense2def/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Dutch/Omega/w2v/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Dutch/Omega/w2v/commondefs/wiki-w2v.nl.t7

echo "French w2v:"
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/French/Omega/Adagram.15-MappingDef2Sense/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/French/Omega/Adagram.15-MappingDef2Sense/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/French/Omega/Adagram.15-MappingSense2def/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/French/Omega/Adagram.15-MappingSense2def/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/French/Omega/w2v/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/French/Omega/w2v/commondefs/wiki-w2v.fr.t7

th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/French/Wiktionary/Adagram.15-MappingDef2Sense/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/French/Wiktionary/Adagram.15-MappingDef2Sense/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/French/Wiktionary/Adagram.15-MappingSense2def/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/French/Wiktionary/Adagram.15-MappingSense2def/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/French/Wiktionary/w2v/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/French/Wiktionary/w2v/commondefs/wiki-w2v.fr.t7

echo "German w2v:"
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/German/Omega/Adagram.15-MappingDef2Sense/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/German/Omega/Adagram.15-MappingDef2Sense/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/German/Omega/Adagram.15-MappingSense2def/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/German/Omega/Adagram.15-MappingSense2def/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/German/Omega/w2v/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/German/Omega/w2v/commondefs/wiki-w2v.de.t7

th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/German/Wiktionary/Adagram.15-MappingDef2Sense/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/German/Wiktionary/Adagram.15-MappingDef2Sense/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/German/Wiktionary/Adagram.15-MappingSense2def/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/German/Wiktionary/Adagram.15-MappingSense2def/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/German/Wiktionary/w2v/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/German/Wiktionary/w2v/commondefs/wiki-w2v.de.t7

echo "Greek w2v:"
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Greek/WordNet/Adagram.15-MappingDef2Sense/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Greek/WordNet/Adagram.15-MappingDef2Sense/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Greek/WordNet/Adagram.15-MappingSense2def/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Greek/WordNet/Adagram.15-MappingSense2def/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Greek/WordNet/w2v/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Greek/WordNet/w2v/commondefs/wiki-w2v.el.t7

echo "Italian w2v:"
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Italian/Omega/Adagram.15-MappingDef2Sense/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Italian/Omega/Adagram.15-MappingDef2Sense/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Italian/Omega/Adagram.15-MappingSense2def/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Italian/Omega/Adagram.15-MappingSense2def/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Italian/Omega/w2v/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Italian/Omega/w2v/commondefs/wiki-w2v.it.t7

th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Italian/WordNet/Adagram.15-MappingDef2Sense/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Italian/WordNet/Adagram.15-MappingDef2Sense/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Italian/WordNet/Adagram.15-MappingSense2def/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Italian/WordNet/Adagram.15-MappingSense2def/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Italian/WordNet/w2v/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Italian/WordNet/w2v/commondefs/wiki-w2v.it.t7

echo "Japanese w2v:"
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Japanese/WordNet/Adagram.15-MappingDef2Sense/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Japanese/WordNet/Adagram.15-MappingDef2Sense/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Japanese/WordNet/Adagram.15-MappingSense2def/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Japanese/WordNet/Adagram.15-MappingSense2def/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Japanese/WordNet/w2v/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Japanese/WordNet/w2v/commondefs/wiki-w2v.ja.t7

echo "Russian w2v:"
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Russian/Wiktionary/Adagram.15-MappingDef2Sense/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Russian/Wiktionary/Adagram.15-MappingDef2Sense/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Russian/Wiktionary/Adagram.15-MappingSense2def/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Russian/Wiktionary/Adagram.15-MappingSense2def/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Russian/Wiktionary/w2v/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Russian/Wiktionary/w2v/commondefs/wiki-w2v.ru.t7

echo "Spanish w2v:"
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Spanish/Omega/Adagram.15-MappingDef2Sense/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Spanish/Omega/Adagram.15-MappingDef2Sense/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Spanish/Omega/Adagram.15-MappingSense2def/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Spanish/Omega/Adagram.15-MappingSense2def/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Spanish/Omega/w2v/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Spanish/Omega/w2v/commondefs/wiki-w2v.es.t7

th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Spanish/WordNet/Adagram.15-MappingDef2Sense/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Spanish/WordNet/Adagram.15-MappingDef2Sense/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Spanish/WordNet/Adagram.15-MappingSense2def/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Spanish/WordNet/Adagram.15-MappingSense2def/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Spanish/WordNet/w2v/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/Spanish/WordNet/w2v/commondefs/wiki-w2v.es.t7

echo "English w2v:"
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/Omega/Adagram.15-MappingDef2Sense/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/Omega/Adagram.15-MappingDef2Sense/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/Omega/Adagram.15-MappingSense2def/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/Omega/Adagram.15-MappingSense2def/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/Omega/w2v/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/Omega/w2v/commondefs/wiki-w2v.en.t7

th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/Wiktionary/Adagram.15-MappingDef2Sense/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/Wiktionary/Adagram.15-MappingDef2Sense/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/Wiktionary/Adagram.15-MappingSense2def/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/Wiktionary/Adagram.15-MappingSense2def/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/Wiktionary/w2v/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/Wiktionary/w2v/commondefs/wiki-w2v.en.t7

th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/WordNet/Adagram.15-MappingDef2Sense/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/WordNet/Adagram.15-MappingDef2Sense/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/WordNet/Adagram.15-MappingSense2def/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/WordNet/Adagram.15-MappingSense2def/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/WordNet/w2v/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/WordNet/w2v/commondefs/wiki-w2v.en.t7

th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/GCIDE-WN/Adagram.15-MappingDef2Sense/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/GCIDE-WN/Adagram.15-MappingDef2Sense/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/GCIDE-WN/Adagram.15-MappingSense2def/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/GCIDE-WN/Adagram.15-MappingSense2def/commondefs/embeddings.t7
th prep_w2v.lua --dataDir /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/GCIDE-WN/w2v/commondefs --w2vPath /home/akabiri/arman.kabiri94@gmail.com/NLP_Stuff/DefinitionModeling_Noraset--IG--/data_phase2/English/GCIDE-WN/w2v/commondefs/wiki-w2v.en.t7

echo "DOOOOOOOOOOOOOOOOOONNNNNNNNNNNNEEEEEEEEEEEEEEE!!!!! :-D\n"
