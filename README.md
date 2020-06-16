# Multi-sense-Multi-lingual-Definition-Modeling
#### The source code and datasets for TSD paper: "Evaluating a Multi-sense Definition GenerationModel for Multiple Languages"

This work is an extension to the single-sense definition generation model proposed by Noraset el al. [[1]](#1). The pipeline to get the results reported in our TSD paper is to first run the pre-processing scripts released on the repository, and then feed the Noraset model with the pre-processed data to get multi-sense definitions. As our experiments are conducted on nine languages, some scripts are also prepared to enable the model dealing with non-English definitions.

---
### Installation:

* To run the experiments, install python3. Then, you need to install the following packages:

`
sudo pip install gensim numpy pandas nltk tqdm many-stop-words cltk JapaneseTokenizer
`

* Since the base single-sense model is implemented in Lua with Torch, you also need to install Lua Torch:
Follow the instructions on the official website (http://torch.ch/docs/getting-started.html)

* Moreover, the multi-sense embeddings used for the experiments reported on the paper are trained by AdaGram which is implemented in Julia. To install julia, check its website (https://julialang.org), and to install AdaGram package, check its repository (https://github.com/sbos/AdaGram.jl).

---
---
## Running experiments:

### Extracting AdaGram Multi-sense embeddings:

Trying to train AdaGram embeddings on various languages' corpora, we realized that AdaGram method is not completely compatible with other languages than English. Therefore, we propose to first transform all the words of the working language to indices, train embeddings, and then transorm them back the original words. To do so, run the following commands with arguments:

* First, tokenize the corpus using tokenize_NonEnglish_Customized.sh (This is the modified version of the script published in AdaGram/utils repository which is compatible with ALL languages):

`
bash tokenize_NonEnglish_Customized.sh <input_corpus_text_file> <output_tokenized_corpus_text_file>
`

* Then, get the frequency dictionary of the corpus (dictionary.sh script is located in AdaGram/utils repository):

`
bash dictionary.sh <input_tokenized_corpus_text_file> <output_dictionary_text_file>
`

* Next, transform the words of the corpus to indices to be ready for learning of embeddings:

`
python TransformTokenizedCorpusToIndexes.py <input_training_corpus_text_file> <input_dictionary_freq_file> <output_transformed_training_corpus_text_file> <output_transformed_dictionary_freq_file>
`

* After the transformed corpus and dictionary are ready, train the AdaGram model following the instructions on their repository (https://github.com/sbos/AdaGram.jl).

* After training the adagram model (or downloading the pretrained model), we need to extract our desired multi-sense embeddings from the trained model. To extract the embeddings, run the following command with desired arguments:

`
julia extract_AdaGram_embeddings.jl <input_trained_model_file> <output_embeddings_text_file>
`

* The extracted embeddings are for indices. In order to map them back to the original words, run:

`
python TransformIndexedEmbeddingsToOriginalEmbeddings.py <input_extracted_transformed_embeddings_file> <input_original_dictionary_freq_file> <output_original_embeddings_file> UNK
`

After going through the above explained steps, the multi-sense embeddings will be ready.

---
### Datasets:
Pre-processed datasets for our experiments (dictionaries) are available in DataSets directory. If you wish to go through the process of preparing them by yourself, use the follwoing scrip files:

* BabelNet_DefinitionsExtractor/Extract_Definitions.java: for extracting OmegaWiki and some WordNet dictionaries from BabelNet Project.

* The scripts in Parse_WordNet_Dictionary directory: for parsing downloaded raw wordnet_dictionaries.

* The scripts in Wiktionary_Parser directory: for parsing wiktionary downloaded raw files.

---
## References
<a id="1">[1]</a> 
Noraset, T., Liang, C., Birnbaum, L., Downey, D.: Definition modeling: Learning to define word embeddings in natural language. In: AAAI 2017. pp. 3259–3266 (2017)
