# Created by Arman Kabiri on 2019-06-11
# Author's Email Address: Arman.Kabiri94@gmail.com

from collections import OrderedDict
import sys

URI_definitions_input_directory = sys.argv[1]

def_train_file_name = "train.txt"
def_valid_file_name = "valid.txt"
def_test_file_name = "test.txt"


def main():
    definitions_train = load_definitions([], def_train_file_name)
    definitions_valid = load_definitions([], def_valid_file_name)
    definitions_test = load_definitions([], def_test_file_name)

    #analyze_occuranceOfTargetWordInDefinition(definitions_train)
    analyze_commonWordsBetweenTwoSets(definitions_test, definitions_train)


def analyze_occuranceOfTargetWordInDefinition(definitions: OrderedDict):
    counter = 0
    for word, definition in definitions.items():
        if word.split('#')[0] in definition[0]:
            counter += 1
            if counter<100:
                print(word,' -> ',definition[0])

    print(str(counter) + ' out of ' + str(len(definitions.keys())))


def analyze_commonWordsBetweenTwoSets(defSetSmall: OrderedDict, defSetLarge: OrderedDict):
    vocab_largeSet = {wordItr.split('#')[0] for wordItr, _ in defSetLarge.items()}
    counter = 0
    for word, _ in defSetSmall.items():
        if word.split('#')[0] in vocab_largeSet:
            counter += 1

    print('Common words between two sets: ', counter / len(defSetSmall) * 100, ' %')


def load_definitions(allowed_dictionaries: list, fileName: str) -> OrderedDict:
    print('loading definitions\n')
    definitions = OrderedDict()
    lines = open(URI_definitions_input_directory + '/' + fileName, "r").readlines()
    last_word = ''
    definition_counter = 1
    for line in lines:
        word, POSTag, def_source, definition = line.rstrip("\r\n").split("\t")
        if len(allowed_dictionaries) == 0 or def_source in allowed_dictionaries:
            if last_word.lower() != word.lower():
                definition_counter = 1

            definitions[word + '#' + str(definition_counter)] = (definition, POSTag, def_source, fileName.split(".")[0])
            definition_counter += 1
            last_word = word

    print('definitions are loaded\n')
    return definitions


if __name__ == "__main__":
    main()
