# Author: Arman Kabiri
# Email: Arman.Kabiri94@gmail.com

import os
import gensim
from WordDefinitionEntry import WordDefEntry
import numpy as np
from collections import OrderedDict
import nltk
from nltk import word_tokenize
from nltk.corpus import stopwords
import string
from tqdm import tqdm
import sys
import os.path
from functools import cmp_to_key
from pathlib import Path
from shutil import copyfile
import many_stop_words


nltk.download('stopwords')
nltk.download('punkt')

URI_SenseEmbeddings_binfile = sys.argv[1]
URI_definitions_input_directory = sys.argv[2]
URI_definitions_output_directory = os.path.join(sys.argv[3], 'commondefs')

# Mapping Mode:
# 'sense2def' or 'def2sense-hard' or 'def2sense-soft' or 'noMapping'
mapping_mode = sys.argv[4]
are_usageExamples_available = sys.argv[5] == 'yes'
language = sys.argv[6]

URI_shortlist_output_directory = os.path.join(URI_definitions_output_directory, 'shortlist')

URI_vocab_output_file = 'vocab.txt'

URI_shortlist_train_output_file = 'shortlist_train.txt'
URI_shortlist_valid_output_file = 'shortlist_valid.txt'
URI_shortlist_test_output_file = 'shortlist_test.txt'
URI_shortlist_all_output_file = 'shortlist_all.txt'

def_train_file_name = "train.txt"
def_valid_file_name = "valid.txt"
def_test_file_name = "test.txt"

embeddings_dim = 0


def main():

    # Creating folder structures...
    dirToMake = Path(os.path.join(URI_definitions_output_directory, 'models/cur'))
    dirToMake.mkdir(exist_ok=True, parents=True)
    dirToMake = Path(os.path.join(URI_definitions_output_directory, 'shortlist'))
    dirToMake.mkdir(exist_ok=True, parents=True)

    # Loading Embeddings
    sense_embeddings_dic = load_embeddings()

    definitions_train = load_definitions([], def_train_file_name)
    definitions_valid = load_definitions([], def_valid_file_name)
    definitions_test = load_definitions([], def_test_file_name)

    if mapping_mode.lower() == 'sense2def':
        wordDefEntities_train = perform_mapping_sense2def(sense_embeddings_dic, definitions_train)
        wordDefEntities_valid = perform_mapping_sense2def(sense_embeddings_dic, definitions_valid)
        wordDefEntities_test = perform_NoMapping(sense_embeddings_dic, definitions_test)
    elif mapping_mode.lower().split('-')[0] == 'def2sense':
        mappingCertainity = mapping_mode.lower().split('-')[1]  # hard or soft
        wordDefEntities_train = perform_mapping_def2sense(sense_embeddings_dic, definitions_train, mappingCertainity)
        wordDefEntities_valid = perform_mapping_def2sense(sense_embeddings_dic, definitions_valid, mappingCertainity)
        wordDefEntities_test = perform_NoMapping(sense_embeddings_dic, definitions_test)
    elif mapping_mode.lower() == 'nomapping':
        wordDefEntities_train = perform_NoMapping(sense_embeddings_dic, definitions_train)
        wordDefEntities_valid = perform_NoMapping(sense_embeddings_dic, definitions_valid)
        wordDefEntities_test = perform_NoMapping(sense_embeddings_dic, definitions_test)

    else:
        exit("Wrong mapping mode")

    save_definition_files(wordDefEntities_train, def_train_file_name)
    save_definition_files(wordDefEntities_valid, def_valid_file_name)
    save_definition_files(wordDefEntities_test, def_test_file_name)

    save_shortlist_files(wordDefEntities_train + wordDefEntities_valid + wordDefEntities_test)

    print('Writing Embeddings File.')
    if mapping_mode.lower() == 'def2sense-soft':
        print('Convert the embeddings to t7 file.')
        save_embeddings_file(sense_embeddings_dic)
    else:
        URI_SenseEmbeddings_t7file = os.path.splitext(URI_SenseEmbeddings_binfile)[0] + '.t7'
        if os.path.exists(URI_SenseEmbeddings_t7file):
            copyfile(URI_SenseEmbeddings_t7file, os.path.join(URI_definitions_output_directory, 'embeddings.t7'))
        else:
            print('Convert the embeddings to t7 file.')
            copyfile(URI_SenseEmbeddings_binfile, os.path.join(URI_definitions_output_directory, 'embeddings.bin'))

    # statistical_analysis(wordDefEntities)


def load_embeddings() -> OrderedDict:
    print('Loading embeddings\n')
    model = gensim.models.KeyedVectors.load_word2vec_format(fname=URI_SenseEmbeddings_binfile,
                                                            binary=True)
    global embeddings_dim
    embeddings_dim = model.vector_size

    embeddingsDic = OrderedDict()
    vectors = model.vectors
    vocabs = model.index2word
    for w, v in zip(vocabs, vectors):
        embeddingsDic[w] = v

    print('Embeddings are loaded\n')
    return embeddingsDic


def load_definitions(allowed_dictionaries: list, fileName: str) -> OrderedDict:
    print('loading definitions\n')
    definitions = OrderedDict()
    lines = open(URI_definitions_input_directory + '/' + fileName, "r").readlines()
    last_word = ''
    definition_counter = 1

    for line in lines:
        if are_usageExamples_available:
            word, POSTag, def_source, definition, usageExample = line.strip("\r\n").split("\t")
        else:
            word, POSTag, def_source, definition = line.strip("\r\n").split("\t")
            usageExample = ""

        if len(allowed_dictionaries) == 0 or def_source in allowed_dictionaries:
            if last_word.lower() != word.lower():
                definition_counter = 1

            definitions[word + '#' + str(definition_counter)] = (
                definition, usageExample, POSTag, def_source, fileName.split(".")[0])
            definition_counter += 1
            last_word = word

    print('definitions are loaded\n')
    return definitions


def perform_mapping_sense2def(sense_embeddings_dic: OrderedDict, definitions: OrderedDict) -> list:
    print('Mapping starts.')
    wordDefEntries = []
    cache_lastItr_definitionsSet = []
    cache_last_original_word = ""

    for word, vector in tqdm(sense_embeddings_dic.items()):
        # If the embedding is for a sense, not for a word
        if len(word.split("#")) == 2:
            original_word = word.split("#")[0]  # removing _n part
            if cache_last_original_word.lower() == original_word.lower():
                definitions_similarities_dic = cache_lastItr_definitionsSet
            else:
                # Similarities are set to 0 in this part
                definitions_similarities_dic = get_all_word_definitions(original_word, definitions)
                cache_last_original_word = original_word
                cache_lastItr_definitionsSet = definitions_similarities_dic

            atleast_onedef_is_seen = False
            if bool(definitions_similarities_dic):
                for definition in definitions_similarities_dic:
                    definition_emb = get_expression_vector((definition[0] + ' ' + definition[1]).strip(), sense_embeddings_dic,
                                                           original_word)
                    if definition_emb is not None:
                        sim = cosine_similarity(vector, definition_emb)
                        definitions_similarities_dic[definition] = sim
                        atleast_onedef_is_seen = True

                if atleast_onedef_is_seen:
                    pickedDefinition = pick_the_highest(definitions_similarities_dic)
                    wordDefEntries.append(WordDefEntry(word, pickedDefinition, vector))

    # OOV words:
    vocab_dataset = set(definitions.keys())
    vocab_embeddings = set(word.split('#')[0] for word in sense_embeddings_dic.keys())
    vocab_OOV = set(word for word in vocab_dataset if word.split('#')[0] not in vocab_embeddings)

    for word in vocab_OOV:
        definition = definitions[word]
        sense = word.split('#')[0] + '#1'
        wordDefEntries.append(WordDefEntry(sense, definition, None))

    return wordDefEntries


def perform_mapping_def2sense(sense_embeddings_dic: OrderedDict, definitions: OrderedDict, mappingCertainity) -> list:
    print('Mapping starts.\n')
    wordDefEntries = []
    cache_lastWord_senses = {}
    cache_last_original_word = ""
    for word, definition in tqdm(definitions.items()):
        original_word = word.split('#')[0]
        if cache_last_original_word.lower() == original_word.lower():
            wordSenses = cache_lastWord_senses
        else:
            # Similarities are set to 0 in this part
            wordSenses = get_all_wordSenses(original_word, sense_embeddings_dic)
            cache_last_original_word = original_word
            cache_lastWord_senses = wordSenses

        if bool(wordSenses):
            last_sense_number = max([int(sense.split('#')[1]) for sense in wordSenses.keys()])
            if last_sense_number == 1:
                pickedSense = list(wordSenses.keys())[0]
                wordDefEntries.append(WordDefEntry(pickedSense, definition, wordSenses[pickedSense]))
            else:
                definition_emb = get_expression_vector((definition[0] + ' ' + definition[1]).strip(), sense_embeddings_dic,
                                                       original_word)
                if definition_emb is not None:
                    sense_similarities = {}
                    for sense, senseVector in wordSenses.items():
                        sim = cosine_similarity(senseVector, definition_emb)
                        sense_similarities[sense] = sim

                    if mappingCertainity == 'hard':
                        pickedSense = pick_the_highest(sense_similarities)
                    elif mappingCertainity == 'soft':
                        pickedSense = original_word + '#' + str(last_sense_number + 1)
                        wordSenses[pickedSense] = weightedSum(sense_similarities, wordSenses)
                        sense_embeddings_dic[pickedSense] = wordSenses[pickedSense]
                    else:
                        exit('UnSupported mapping mode!')

                    wordDefEntries.append(WordDefEntry(pickedSense, definition, wordSenses[pickedSense]))
        else:
            OOV_sense = original_word + '#1'
            wordDefEntries.append(WordDefEntry(OOV_sense, definition, None))

    return wordDefEntries


def perform_NoMapping(sense_embeddings_dic: OrderedDict, definitions: OrderedDict) -> list:
    print('Mapping starts.\n')
    wordDefEntries = []
    cache_lastWord_senses = {}
    cache_last_original_word = ""
    for word, definition in tqdm(definitions.items()):
        original_word = word.split('#')[0]
        if cache_last_original_word.lower() == original_word.lower():
            wordSenses = cache_lastWord_senses
        else:
            wordSenses = get_all_wordSenses(original_word, sense_embeddings_dic)
            if not bool(wordSenses):
                wordSenses[original_word + '#1'] = None
            cache_last_original_word = original_word
            cache_lastWord_senses = wordSenses

        for sense in wordSenses:
            wordDefEntries.append(WordDefEntry(sense, definition, wordSenses[sense]))

    return wordDefEntries


def get_all_word_definitions(word: str, definitions: OrderedDict) -> dict:
    # Caution: definitions should necessarily be ordered dict
    word_definitions = {}
    for i in range(1, 1000):
        word_temp = word + '#' + str(i)
        if word_temp in definitions:
            word_definitions[definitions[word_temp]] = 0
        else:
            break

    return word_definitions


def get_all_wordSenses(word: str, sense_embeddings_dic: OrderedDict) -> dict:
    # Caution: definitions should necessarily be ordered dict
    word_senses = {}
    for i in range(1, 1000):
        sense = word + '#' + str(i)
        if sense in sense_embeddings_dic:
            word_senses[sense] = sense_embeddings_dic[sense]
        else:
            break

    return word_senses


def cosine_similarity(v1, v2):
    dot = np.dot(v1, v2)
    norm_v1 = np.linalg.norm(v1)
    norm_v2 = np.linalg.norm(v2)
    cos = dot / (norm_v1 * norm_v2)
    return cos


# It also could return None if we do not have embeddings for any of the def words
def get_expression_vector(strInput: str, embeddings: OrderedDict, targetWord=None) -> list:
    if language.lower() == 'japanese':
        stop = list(many_stop_words.get_stop_words('ja')) + list(string.punctuation)
    else:
        stop = stopwords.words(language) + list(string.punctuation)

    stop.append('<TRG>')
    if targetWord:
        stop.append(targetWord)

    def_tokens = [i for i in word_tokenize(strInput.lower()) if i not in stop]
    n_found_tokens = 0
    expression_vector = np.array([0.0 for i in range(embeddings_dim)])

    for token in def_tokens:
        if token in embeddings:
            n_found_tokens += 1
            expression_vector += np.array(embeddings[token])

    if n_found_tokens != 0:
        expression_vector = expression_vector / n_found_tokens
        return expression_vector.tolist()
    else:
        return None


# Returning the most probable definition
def pick_the_highest(definitions_similarities_dic):
    highest = ["def", float("-inf")]
    for defItr, simItr in definitions_similarities_dic.items():
        if simItr > highest[1]:
            highest[0] = defItr
            highest[1] = simItr
    return highest[0]


def save_definition_files(wordDefEntities: list, fileName):
    file = open(URI_definitions_output_directory + '/' + fileName, "w+")

    for entry in wordDefEntities:
        # Line Format : word    POS     def source      definition
        line = entry.word + "\t" + entry.definition[2] + "\t" + entry.definition[3] + "\t" + entry.definition[
            0] + "\n"
        file.write(line)

    file.close()


def save_shortlist_files(wordDefEntities: list):
    # Instead of using sets, I used OrderedDict to preserve the order of the list
    list_all, list_train, list_valid, list_test = OrderedDict(), OrderedDict(), OrderedDict(), OrderedDict()
    vocab = set()

    for entry in wordDefEntities:
        if entry.definition[-1] == def_train_file_name.split(".")[0]:
            list_train[entry.word] = 0
            list_all[entry.word] = 0
        elif entry.definition[-1] == def_valid_file_name.split(".")[0]:
            list_valid[entry.word] = 0
            list_all[entry.word] = 0
        elif entry.definition[-1] == def_test_file_name.split(".")[0]:
            list_test[entry.word] = 0
            list_all[entry.word] = 0

        vocab.update(entry.definition[0].split(' '))
        vocab.update(entry.word)

    with open(URI_shortlist_output_directory + '/' + URI_shortlist_all_output_file, "w+") as file:
        for v in list_all:
            file.write(v + "\n")

    with open(URI_shortlist_output_directory + '/' + URI_shortlist_train_output_file, "w+") as file:
        for v in list_train:
            file.write(v + "\n")

    with open(URI_shortlist_output_directory + '/' + URI_shortlist_valid_output_file, "w+") as file:
        for v in list_valid:
            file.write(v + "\n")

    with open(URI_shortlist_output_directory + '/' + URI_shortlist_test_output_file, "w+") as file:
        for v in list_test:
            file.write(v + "\n")

    vocab_file = open(URI_definitions_output_directory + '/' + URI_vocab_output_file, "w+")
    for v in vocab:
        vocab_file.write(v + "\n")
    # Adding extra tokens to the vocab:
    additional_tokens = ["<def>", "<s>", "</s>"]
    for v in additional_tokens:
        vocab_file.write(v + "\n")
    vocab_file.close()


def save_embeddings_file(updated_sense_embeddings: OrderedDict):
    sense_embeddings_toWrite = OrderedDict()

    # --------Sorting-----------------:
    def compare(a: str, b: str):
        aParts = a.split('#')
        bParts = b.split('#')
        if len(aParts) == 1:
            aParts.append(0)
        else:
            aParts[1] = int(aParts[1])
        if len(bParts) == 1:
            bParts.append(0)
        else:
            bParts[1] = int(bParts[1])

        if aParts[0] == bParts[0]:
            return 1 if aParts[1] > bParts[1] else -1
        else:
            return 1 if aParts[0] > bParts[0] else -1

    for sense in sorted(updated_sense_embeddings.keys(), key=cmp_to_key(compare)):
        sense_embeddings_toWrite[sense] = updated_sense_embeddings[sense]
    # --------------------------------

    updated_sense_embeddings = None
    modelvectors = gensim.models.keyedvectors.Word2VecKeyedVectors(embeddings_dim)
    modelvectors.add(list(sense_embeddings_toWrite.keys()), list(sense_embeddings_toWrite.values()), replace=True)
    modelvectors.save_word2vec_format(fname=os.path.join(URI_definitions_output_directory, 'emb_updated.bin'),
                                      binary=True)


def weightedSum(sense_sim_dict: dict, wordSenseVectors: dict) -> list:
    # Calculation is done using softmax function
    aggregated_sense_vector = np.array([0.0 for i in range(embeddings_dim)])
    denominator = float(sum(np.exp(list(sense_sim_dict.values()))))
    for sense, similarity in sense_sim_dict.items():
        aggregated_sense_vector += (np.exp(similarity) / denominator) * wordSenseVectors[sense]

    return aggregated_sense_vector


def statistical_analysis(wordDefEntities: list):
    definitions_set = set()
    unique_words = set()
    last_word = ""
    sum_number_of_defs_per_word = 0
    for entry in wordDefEntities:
        unique_words.add(entry.word.split("#")[0])
        if last_word.lower().split("#")[0] == entry.word.lower().split("#")[0]:
            definitions_set.add(entry.definition)
        else:
            sum_number_of_defs_per_word += len(definitions_set)
            last_word = entry.word
            definitions_set.clear()
            definitions_set.add(entry.definition)

    avg_def_per_word = sum_number_of_defs_per_word / len(unique_words)
    print("Average Number of different definitions per word: " + str(avg_def_per_word))


if __name__ == "__main__":
    main()
    print("Done!")
