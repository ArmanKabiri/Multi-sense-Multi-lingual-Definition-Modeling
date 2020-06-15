import gensim
from gensim.models.keyedvectors import Word2VecKeyedVectors
from collections import OrderedDict
import sys
import numpy as np
from tqdm import tqdm

URI_SenseEmbeddings_binfile = sys.argv[1]
URI_definitions_input_directory = ''
URI_analysis_output_file = ''

def_train_file_name = "train.txt"
def_valid_file_name = "valid.txt"
def_test_file_name = "test.txt"

topN = 30


def main():
    embeddings_gensim, embeddings_dict = load_embeddings()
    # definitions_train = load_definitions(def_train_file_name)
    # definitions_valid = load_definitions(def_valid_file_name)
    # definitions_test = load_definitions(def_test_file_name)
    #
    # definitions_train.update(definitions_test)
    # definitions_train.update(definitions_valid)
    # definitions = definitions_train

    definitions = None

    # analyze_neighbour_words(embeddings_gensim, embeddings_dict, definitions)
    analyze_sensesSimilarities(embeddings_dict)


def analyze_neighbour_words(embeddings_gensim: Word2VecKeyedVectors, embeddings_dict: OrderedDict,
                            definitions: OrderedDict):
    output_file = open(URI_analysis_output_file, "w+")
    words_list = ['bed', 'book', 'chair', 'box', 'right', 'bank', 'second', 'express', 'face', 'fast', 'head', 'hunt',
                  'light', 'blackberry', 'head', 'tie', 'digit']

    for word in words_list:
        for i in range(1, 1000):
            ready_word = word.lower() + '#' + str(i)
            if ready_word not in embeddings_dict:
                break
            nearest_words = embeddings_gensim.most_similar(positive=[ready_word], topn=topN)
            nearest_wordsDict = {}
            for wordX, similarity in nearest_words:
                if wordX.split('#')[0] != ready_word.split('#')[0] and wordX.split('#')[0] not in nearest_wordsDict:
                    nearest_wordsDict[wordX.split('#')[0]] = similarity

            output_file.write("Word: " + ready_word + "\n")

            if definitions is not None:
                output_file.write(
                    "Mapped definition: " + (
                        definitions[ready_word][
                            0] if ready_word in definitions else "Deffinition does not exist") + "\n")

            output_file.write("The nearest neighbours to word '" + ready_word + "' are:\n")
            output_file.write("\n".join(map(str, nearest_wordsDict)))
            output_file.write("\n---------------------------------------------------------\n")

    output_file.close()


def analyze_sensesSimilarities(embeddings_dict: OrderedDict):
    words = set()
    for sense, vector in embeddings_dict.items():
        words.add(sense.split('#')[0])

    macro_avg = 0
    macro_avg_of_minimums = 0
    words_count = 0
    avg_senses_per_word = 0
    for word in tqdm(words):
        micro_avg = 0
        minimum_sim = float('+inf')
        similarities_count = 0
        wordSenses = get_all_wordSenses(word, embeddings_dict)
        avg_senses_per_word += len(wordSenses)
        if len(wordSenses) > 1:
            for i, senseVec1 in enumerate(wordSenses):
                for j, senseVec2 in enumerate(wordSenses):
                    if j > i:
                        sim = cosine_similarity(senseVec1, senseVec2)
                        micro_avg += sim
                        if sim < minimum_sim:
                            minimum_sim = sim
                        similarities_count += 1
            micro_avg = micro_avg / similarities_count
            macro_avg += micro_avg
            macro_avg_of_minimums += minimum_sim
            words_count += 1

    macro_avg = macro_avg / words_count
    macro_avg_of_minimums = macro_avg_of_minimums / words_count
    avg_senses_per_word = avg_senses_per_word / len(words)

    print('\nAverage of similarities between different senses of each word = ' + str(macro_avg))
    print('\nAverage of minimum similarities between different senses of each word = ' + str(macro_avg_of_minimums))
    print(f"\nAverage of number of senses per word is {avg_senses_per_word}\n")

def get_all_wordSenses(word: str, sense_embeddings_dic: OrderedDict) -> list:
    # Caution: definitions should necessarily be ordered dict
    word_senses = []
    for i in range(1, 1000):
        sense = word + '#' + str(i)
        if sense in sense_embeddings_dic:
            word_senses.append(sense_embeddings_dic[sense])
        else:
            break

    return word_senses


def cosine_similarity(v1, v2):
    dot = np.dot(v1, v2)
    norm_v1 = np.linalg.norm(v1)
    norm_v2 = np.linalg.norm(v2)
    cos = dot / (norm_v1 * norm_v2)
    return cos


def load_embeddings():
    print('Loading embeddings.\n')
    embeddings = gensim.models.KeyedVectors.load_word2vec_format(fname=URI_SenseEmbeddings_binfile,
                                                                 binary=True)
    embeddingsDic = OrderedDict()
    vectors = embeddings.vectors
    vocabs = embeddings.index2word
    for w, v in zip(vocabs, vectors):
        embeddingsDic[w] = v

    return embeddings, embeddingsDic


def load_definitions(fileName: str) -> OrderedDict:
    definitions = OrderedDict()
    lines = open(URI_definitions_input_directory + fileName, "r").readlines()
    for line in lines:
        word, POSTag, def_source, definition = line.rstrip("\r\n").split("\t")
        definitions[word] = (definition, POSTag, def_source, fileName.split(".")[0])

    return definitions


if __name__ == "__main__":
    main()
