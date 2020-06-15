# Created by Arman Kabiri on 2019-08-22 - 12:50 p.m.
# Author's Email Address: Arman.Kabiri94@gmail.com


import sys
from collections import OrderedDict
import random
import math
import os.path
from nltk.tokenize import word_tokenize
from pathlib import Path
from cltk.tokenize.word import WordTokenizer as CLTK_WordTokenizer
from WordDefinitionEntry import WordDefEntry

URI_definitions_input_directory = sys.argv[1]
URI_definitions_output_directory = sys.argv[2]
are_usageExamples_available = sys.argv[3] == 'yes'    # [yes,no]
language = sys.argv[4]
n_words_cutoff = int(sys.argv[5])       # 0 means no down sampling

URI_shortlist_output_directory = os.path.join(URI_definitions_output_directory, 'shortlist')

URI_vocab_output_file = 'vocab.txt'

URI_shortlist_train_output_file = 'shortlist_train.txt'
URI_shortlist_valid_output_file = 'shortlist_valid.txt'
URI_shortlist_test_output_file = 'shortlist_test.txt'
URI_shortlist_all_output_file = 'shortlist_all.txt'

def_train_file_name = "train.txt"
def_valid_file_name = "valid.txt"
def_test_file_name = "test.txt"

dataPortion = (.8, .1, .1)  # Train - Valid - Test


# This code also preprocess the dictionaries entities.
def main():
    if sum(dataPortion) != 1:
        exit('Data Portions are not set correctly.')

    # Creating folder structures...
    dirToMake = Path(os.path.join(URI_definitions_output_directory, 'shortlist'))
    dirToMake.mkdir(exist_ok=True, parents=True)

    definitions_train = load_definitions_customized3([], def_train_file_name)
    definitions_valid = load_definitions_customized3([], def_valid_file_name)
    definitions_test = load_definitions_customized3([], def_test_file_name)

    definitions_all = mergeDatasets(definitions_train, definitions_valid, definitions_test)

    # Down Sampling ...
    if n_words_cutoff > 0:
        print(f"down sampling to {n_words_cutoff} words.")
        words = list(definitions_all.keys())
        random.shuffle(words)
        words = words[:int(n_words_cutoff)]
        definitions_all = {word: definitions_all[word] for word in words}

    # definitions_test, definitions_valid, definitions_train = None, None, None

    definitions_train, definitions_valid, definitions_test = reconstruct(definitions_all)

    save_definition_files(definitions_train, def_train_file_name)
    save_definition_files(definitions_valid, def_valid_file_name)
    save_definition_files(definitions_test, def_test_file_name)

    save_shortlist_files(definitions_train + definitions_valid + definitions_test)

    if language.lower() == 'japanese':
        print('Japanese Tokenizer is not incorporated in this code. It is assumed that the input dataset is already tokenized.')

    print("Done.")


def load_definitions_customized3(allowed_dictionaries: list, fileName: str) -> dict:
    definitions = dict()
    if os.path.isfile(URI_definitions_input_directory + '/' + fileName):
        lines = open(URI_definitions_input_directory + '/' + fileName, "r").readlines()
        n_errors = 0
        for line in lines:
            try:
                if are_usageExamples_available:
                    word, POSTag, def_source, definition, usageExample = line.strip("\r\n").split("\t")
                    usageExample = usageExample.lower()
                    usageExample = tokenize_txt(usageExample)

                else:
                    word, POSTag, def_source, definition, *_ = line.strip("\r\n").split("\t")
                    usageExample = None

                if ' ' not in word:    # Ignoring Phrases.
                    word = word.lower()
                    definition = definition.lower()
                    definition = tokenize_txt(definition)

                    if len(allowed_dictionaries) == 0 or def_source in allowed_dictionaries:
                        if word in definitions:
                            definitions[word].append((definition, usageExample, POSTag, def_source, fileName.split(".")[0]))
                        else:
                            definitions[word] = [(definition, usageExample, POSTag, def_source, fileName.split(".")[0])]
            except ValueError:
                print(line.strip("\r\n").split("\t"))
                n_errors += 1

        print(f"{n_errors} lines were not read successfully.")
    else:
        print(fileName+" file does not exist.")

    return definitions


def tokenize_txt(text: str) -> str:
    if language.lower() == 'japanese':
        # It is assumed that japanese is already tokenized when parsing.
        result = text
    elif language.lower() == 'greek':
        tokenizer = CLTK_WordTokenizer(language)
        tokenized_txt = tokenizer.tokenize(text)
        result = ' '.join(tokenized_txt)
    else:
        tokenized_txt = word_tokenize(text, language, False)
        result = ' '.join(tokenized_txt)
    return result


def mergeDatasets(definitions_train: dict, definitions_valid: dict, definitions_test: dict) -> dict:
    definitions_all = {}
    for word_i, def_list in definitions_train.items():
        if word_i in definitions_all:
            definitions_all[word_i].extend(def_list)
        else:
            definitions_all[word_i] = def_list

    for word_i, def_list in definitions_valid.items():
        if word_i in definitions_all:
            definitions_all[word_i].extend(def_list)
        else:
            definitions_all[word_i] = def_list

    for word_i, def_list in definitions_test.items():
        if word_i in definitions_all:
            definitions_all[word_i].extend(def_list)
        else:
            definitions_all[word_i] = def_list

    return definitions_all


def reconstruct(definitions_all: dict) -> (dict, dict, dict):
    entries_train, entries_valid, entries_test = [], [], []
    words = list(definitions_all.keys())
    random.shuffle(words)
    n_words = len(words)

    splittingBoundies = (0, math.ceil(dataPortion[0] * n_words), math.ceil(sum(dataPortion[0:2]) * n_words), n_words)
    ## Constructing TrainSet
    for word in words[splittingBoundies[0]:splittingBoundies[1]]:
        defList = definitions_all[word]
        for def_i in defList:
            def_i = list(def_i)  # tuple to list
            def_i[-1] = 'train'
            entries_train.append(WordDefEntry(word, tuple(def_i), None))

    ## Constructing ValidSet
    for word in words[splittingBoundies[1]:splittingBoundies[2]]:
        defList = definitions_all[word]
        for def_i in defList:
            def_i = list(def_i)
            def_i[-1] = 'valid'
            entries_valid.append(WordDefEntry(word, tuple(def_i), None))

    ## Constructing TestSet
    for word in words[splittingBoundies[2]:splittingBoundies[3]]:
        defList = definitions_all[word]
        for def_i in defList:
            def_i = list(def_i)
            def_i[-1] = 'test'
            entries_test.append(WordDefEntry(word, tuple(def_i), None))

    return entries_train, entries_valid, entries_test


def save_definition_files(wordDefEntities: list, fileName):
    file = open(URI_definitions_output_directory + '/' + fileName, "w+")

    for entry in wordDefEntities:
        # Line Format : word    POS     def source      definition      usageExample
        line = entry.word + "\t" + entry.definition[2] + "\t" + entry.definition[3] + "\t" + entry.definition[0]
        if are_usageExamples_available:
            line += '\t' + entry.definition[1]
        line += "\n"

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
        vocab.add(entry.word)

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
        if v != '':
            vocab_file.write(v + "\n")
    # Adding extra tokens to the vocab:
    additional_tokens = ["<def>", "<s>", "</s>"]
    for v in additional_tokens:
        vocab_file.write(v + "\n")
    vocab_file.close()


if __name__ == "__main__":
    main()
